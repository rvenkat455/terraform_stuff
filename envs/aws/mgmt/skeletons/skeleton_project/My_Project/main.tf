terraform {
  required_version = ">= 0.11"
}

provider "aws" {
 profile    = "${var.profile}"
 region     = "${var.region}"

}
