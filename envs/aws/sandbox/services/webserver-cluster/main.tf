terraform {
  required_version = ">= 0.11"
}

provider "aws" {
  profile = "${var.profile}"
  region  = "${var.region}"
}

module "webserver_cluster" {
  source = "../../modules/services/webserver-cluster"

  #Web clustername, should be a variable.
  cluster_name = "webservers-stage"

  #S3 Bucket information
  db_remote_state_bucket = "${var.db_remote_state_bucket}"
  db_remote_state_key    = "${var.db_remote_state_key}"
  db_state_lock_dynDB    = "${var.db_state_lock_dynDB}"

  instance_type = "t2.micro"
  min_size      = 2
  max_size      = 2
}

resource "aws_security_group_rule" "allow_testing_inbound" {
  type              = "ingress"
  security_group_id = "${module.webserver_cluster.elb_security_group_id}"

  from_port   = 12345
  to_port     = 12345
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}
