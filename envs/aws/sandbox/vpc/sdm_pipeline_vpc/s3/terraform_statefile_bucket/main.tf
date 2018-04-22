terraform {
  required_version = ">= 0.11"
}

provider "aws" {
 profile    = "${var.profile}"
 region     = "${var.region}"

}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "${var.bucket_name}"

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }
}
