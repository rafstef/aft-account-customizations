# © 2024 Amazon Web Services, Inc. or its affiliates. All Rights Reserved.
# 
# This AWS Content is provided subject to the terms of the AWS Customer Agreement
# available at http://aws.amazon.com/agreement or other written agreement between
# Customer and either Amazon Web Services, Inc. or Amazon Web Services EMEA SARL or both.

resource "aws_cloudwatch_event_rule" "this" {
  name          = "capture-ou-events"
  event_pattern = <<EOF
{
  "source": ["aws.organizations"],
  "detail-type": ["AWS API Call via CloudTrail"],
  "detail": {
    "eventName": ["CreateOrganizationalUnit"]
  }
}
EOF
}

# send event to sqs queue
resource "aws_cloudwatch_event_target" "this" {
  rule      = aws_cloudwatch_event_rule.this.name
  target_id = "SendToQueue"
  arn       = aws_sqs_queue.capture_ou_creation.arn
}

data "archive_file" "register_ou" {
  type                    = "zip"
  source_content_filename = "controltower_registration.py"
  source_content = templatefile("${path.module}/lambdas/controltower_registration.py", {
    ct_main_region = var.ct_main_region
  })
  output_path = "/tmp/controltower_registration.zip"
}

#trivy:ignore:AVD-AWS-0066
resource "aws_lambda_function" "register_ou" {
  filename      = data.archive_file.register_ou.output_path
  function_name = local.lambda_function_name
  role          = aws_iam_role.capture_ou_creation_lambda_role.arn
  handler       = "controltower_registration.lambda_handler"
  runtime       = "python3.11"
  timeout       = 15
}

resource "aws_lambda_event_source_mapping" "register_ou" {
  event_source_arn = aws_sqs_queue.capture_ou_creation.arn
  function_name    = aws_lambda_function.register_ou.arn
}
