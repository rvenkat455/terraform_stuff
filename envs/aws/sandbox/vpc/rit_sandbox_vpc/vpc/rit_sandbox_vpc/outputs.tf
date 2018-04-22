# VPC
output "vpc_id" {
  description = "The ID of the VPC"
  value       = "${module.vpc.vpc_id}"
}

# Subnets
output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = ["${module.vpc.private_subnets}"]
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = ["${module.vpc.public_subnets}"]
}

output "database_subnets" {
  description = "List of IDs of database subnets"
  value       = ["${module.vpc.database_subnets}"]
}

output "elasticache_subnets" {
  description = "List of IDs of elasticache subnets"
  value       = ["${module.vpc.elasticache_subnets}"]
}


# NAT gateways
output "nat_public_ips" {
  description = "List of public Elastic IPs created for AWS NAT Gateway"
  value       = ["${module.vpc.nat_public_ips}"]
}


#### Bastion EC2 Outputs
output "id_bast" {
  description = "List of Bastion instances"
  value       = ["${module.ec2_bastion.id}"]
}

output "public_ip_bastion" {
  description = "List of Bastion ips assigned to the instances"
  value       = ["${module.ec2_bastion.public_ip}"]
}
output "public_dns_bastion" {
  description = "List of Bastion DNS names assigned to the instances"
  value       = ["${module.ec2_bastion.public_dns}"]
}

output "instance_id_bastion" {
  description = "EC2 instance Bastion"
  value       = "${module.ec2_bastion.id[0]}"
}

output "instance_public_dns_bastion" {
  description = "Public_mqtt DNS name assigned to the EC2 instance"
  value       = "${module.ec2_bastion.public_dns[0]}"
}
