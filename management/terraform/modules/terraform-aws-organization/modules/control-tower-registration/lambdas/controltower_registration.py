# © 2024 Amazon Web Services, Inc. or its affiliates. All Rights Reserved.
# 
# This AWS Content is provided subject to the terms of the AWS Customer Agreement
# available at http://aws.amazon.com/agreement or other written agreement between
# Customer and either Amazon Web Services, Inc. or Amazon Web Services EMEA SARL or both.

import sys
from pip._internal import main

# fix for boto3 update to latest version. As of now (March 2024), the boto3 version is 1.28
# controltower functions:
# * list_baselines
# * list_enabled_baselines
# * enable_baseline
# require at least version 1.33

main(['install', '-I', '-q', 'boto3', '--target', '/tmp/',
     '--no-cache-dir', '--disable-pip-version-check'])
sys.path.insert(0, '/tmp/')

import boto3
import json

def lambda_handler(event, context):

    ct_main_region = "${ct_main_region}"
    ct_client = boto3.client('controltower', region_name=ct_main_region)
    ct_baseline = get_baseline(ct_client, 'AWSControlTowerBaseline')
    ic_baseline = get_baseline(ct_client, 'IdentityCenterBaseline')
    print(f"AWSControlTowerBaseline: {json.dumps(ic_baseline, indent=2)}")
    print(f"IdentityCenterBaseline: {json.dumps(ic_baseline, indent=2)}")

    try:
        response = ct_client.list_enabled_baselines(
            filter={
                'baselineIdentifiers': [
                    ic_baseline["arn"]
                ]
            },
            maxResults=10
        )
        ic_enabled_baseline = response["enabledBaselines"][0]
        ic_baseline_params = [{
            'key': 'IdentityCenterEnabledBaselineArn',
            'value': ic_enabled_baseline["arn"]
        }]
    except Exception as e:
        print("No IdentityCenter enabled baseline found")
        ic_baseline_params = []

    for r in event["Records"]:
        record = json.loads(r["body"])
        print(json.dumps(record))
        if not record["detail"]["responseElements"]:
            print("Event not valid, skipping")
            continue
        new_ou = record["detail"]["responseElements"]["organizationalUnit"]
        if not is_registration_enabled(new_ou["id"]):
            print(
                f"registration is disabled for OU {new_ou['name']} ({new_ou['id']})")
            continue
        print(f"Checking OU {new_ou['name']} ({new_ou['id']})")
        response = ct_client.list_enabled_baselines(
            filter={'targetIdentifiers': [new_ou["arn"]]},
            maxResults=10
        )
        if len(response["enabledBaselines"]) == 0:
            print(f"Registering OU {new_ou['name']} ({new_ou['id']})")
            try:
                ct_client.enable_baseline(
                    baselineIdentifier=ct_baseline["arn"],
                    baselineVersion='4.0',
                    targetIdentifier=new_ou["arn"],
                    parameters=ic_baseline_params
                )
            except Exception as e:
                print(e)
                raise Exception(
                    "Problem during registration, check logs for further details")

        elif ct_baseline["arn"] == response["enabledBaselines"][0]["baselineIdentifier"]:
            print(f"OU {new_ou['name']} ({new_ou['id']}) Already registered")
            continue


def is_registration_enabled(ou_id):
    org_client = boto3.client('organizations')
    response = org_client.list_tags_for_resource(
        ResourceId=ou_id
    )
    for tag in response['Tags']:
        if tag['Key'] == 'ct_register':
            return tag['Value'] == "true"
    return False


def get_baseline(client, name):
    paginator = client.get_paginator('list_baselines')
    response_iterator = paginator.paginate()
    for response in response_iterator:
        for baseline in response["baselines"]:
            if baseline["name"] == name:
                return baseline

    return None


