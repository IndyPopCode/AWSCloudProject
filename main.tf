locals {
  s3_bucket_name = "myBucket"
}
#creating the s3 bucket
resource "aws_s3_bucket" "main" {
  bucket = local.s3_bucket_name
}

#creating the cloudfront distribution
resource "aws_cloudfront_distribution" "main" {
  default_root_object = "index.html"
  enabled             = true
  is_ipv6_enabled     = true
  wait_for_deployment = true

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    cached_methods         = ["GET", "HEAD", "OPTIONS"]
    cache_policy_id        = "658327ea-f89d-4fab-a63d-7e88639e58f6"
    target_origin_id       = aws_s3_bucket.main.bucket
    viewer_protocol_policy = "redirect-to-https"
  }

  origin {
    domain_name              = aws_s3_bucket.main.bucket_regional_domain_name
    origin_id                = aws_s3_bucket.main.bucket
    origin_access_control_id = aws_cloudfront_origin_access_control.main.id
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
  #default certificate 
  viewer_certificate {
    cloudfront_default_certificate = true
  }
}
#providing access for cloudfront to access the bucket
data "aws_iam_policy_document" "cloudfront_oac_access" {
  statement {
    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    actions = [
      "s3:GetObject"
    ]

    resources = ["${aws_s3_bucket.main.arn}/*"]

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values   = [aws_cloudfront_distribution.main.arn]
    }
  }
}

resource "aws_s3_bucket_policy" "main" {
  bucket = aws_s3_bucket.main.id
  policy = data.aws_iam_policy_document.cloudfront_oac_access.json
}
#adding the webpage files to the s3 bucket
resource "aws_s3_object" "webpage_file" {
  for_each     = fileset("${path.module}/S3Content", "*.html")
  bucket       = aws_s3_bucket.main.bucket
  key          = each.value
  content_type = each.value
  source       = "${path.module}/S3Content/${each.value}"
}

