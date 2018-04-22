terraform {
  required_version = ">= 0.11"
}

provider "aws" {
 profile    = "${var.profile}"
 region     = "${var.region}"

}

module "vpc" {
  #source = "../../modules/terraform-aws-vpc"
  #source = "git::https://gitlab.diversey.com/digital/DevOpsEngineeringGroup/terraform-aws-vpc.git"
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-vpc.git"

  name = "com-pipeline-vpc"

  cidr = "10.10.0.0/16"

  azs                 = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  public_subnets      = ["10.10.1.0/24",   "10.10.2.0/24",   "10.10.3.0/24"  ]
  private_subnets     = ["10.10.41.0/24",  "10.10.42.0/24",  "10.10.43.0/24" ]
  database_subnets    = ["10.10.81.0/24",  "10.10.82.0/24",  "10.10.83.0/24" ]
  elasticache_subnets = ["10.10.121.0/24", "10.10.122.0/24", "10.10.123.0/24"]

  create_database_subnet_group = false

  enable_nat_gateway = true
  enable_vpn_gateway = true

  enable_s3_endpoint       = true
  enable_dynamodb_endpoint = true

  enable_dhcp_options              = true
  dhcp_options_domain_name         = "service.consul"
  dhcp_options_domain_name_servers = ["127.0.0.1", "10.10.0.2"]

  tags = {
    Owner       = "user"
    Environment = "dev"
    Name        = "com-pipeline-vpc"
  }
}
