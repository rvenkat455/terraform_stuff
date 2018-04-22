terraform {
  required_version = ">= 0.11"
}

provider "aws" {
 profile    = "${var.profile}"
 region     = "${var.region}"

}


resource "aws_dynamodb_table" "dynamodb-terraform-lock" {
   name = "terraform-lock"
   hash_key = "LockID"
   read_capacity = 20
   write_capacity = 20

   attribute {
      name = "LockID"
      type = "S"
   }

   tags {
     Name = "Terraform Lock Table"
   }
}
