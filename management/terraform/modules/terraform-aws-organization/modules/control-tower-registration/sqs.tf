# © 2024 Amazon Web Services, Inc. or its affiliates. All Rights Reserved.
# 
# This AWS Content is provided subject to the terms of the AWS Customer Agreement
# available at http://aws.amazon.com/agreement or other written agreement between
# Customer and either Amazon Web Services, Inc. or Amazon Web Services EMEA SARL or both.

resource "aws_sqs_queue" "capture_ou_creation" {
  name                    = "capture-ou-creation-${data.aws_caller_identity.current.id}"
  sqs_managed_sse_enabled = true

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.capture_ou_creation_dlq.arn
    maxReceiveCount     = 200
  })
}

resource "aws_sqs_queue_policy" "capture_ou_creation" {
  queue_url = aws_sqs_queue.capture_ou_creation.id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "capture-ou-creation-policy",
  "Statement": [
    {
      "Sid": "__owner_statement",
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:${data.aws_partition.current.partition}:iam::${data.aws_caller_identity.current.id}:root"
      },
      "Action": "SQS:*",
      "Resource": "arn:${data.aws_partition.current.partition}:sqs:${data.aws_region.current.name}:${data.aws_caller_identity.current.id}:capture-ou-creation"
    },
    {
      "Sid": "AWSEvents_${local.lambda_function_name}",
      "Effect": "Allow",
      "Principal": {
        "Service": "events.amazonaws.com"
      },
      "Action": "sqs:SendMessage",
      "Resource": "${aws_sqs_queue.capture_ou_creation.arn}",
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "${aws_cloudwatch_event_rule.this.arn}"
        }
      }
    }
  ]
}
POLICY
}

resource "aws_sqs_queue" "capture_ou_creation_dlq" {
  name                    = "capture-ou-creation-${data.aws_caller_identity.current.id}-dlq"
  sqs_managed_sse_enabled = true
}

resource "aws_sqs_queue_redrive_allow_policy" "capture_ou_creation" {
  queue_url = aws_sqs_queue.capture_ou_creation_dlq.id

  redrive_allow_policy = jsonencode({
    redrivePermission = "byQueue",
    sourceQueueArns   = [aws_sqs_queue.capture_ou_creation.arn]
  })
}

