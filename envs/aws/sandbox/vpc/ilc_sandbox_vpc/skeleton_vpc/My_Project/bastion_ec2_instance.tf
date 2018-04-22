resource "aws_key_pair" "deployer" {
  key_name   = "${var.ec2_user_key}"
  public_key = "${var.ec2_user_key_pub}"
}


# This will retrieve the latest aws_ami 64bit Linux image
data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name = "name"

    values = [
      "amzn-ami-hvm-*-x86_64-gp2",
    ]
  }

  filter {
    name = "owner-alias"

    values = [
      "amazon",
    ]
  }
}


# local ssh support from bastion servers 
module "security_group_bastion_support" {
  source = "./modules/terraform-aws-security-group"
  #source = "git::https://github.com/terraform-aws-modules/terraform-aws-security-group.git"

  name        = "bastion_support_ports"
  description = "Security group for ssh between hosts"
  vpc_id      = "${module.vpc.vpc_id}"

  ingress_cidr_blocks = ["10.10.0.0/16"]
  ingress_rules       = ["ssh-tcp", "ssh-tcp-div", "all-icmp"]
  egress_rules        = ["all-all"]
}


module "security_group_bastion" {
  source = "./modules/terraform-aws-security-group"
  #source = "git::https://github.com/terraform-aws-modules/terraform-aws-security-group.git"

  name        = "Bastion"
  description = "Security group for Bastion Server"
  vpc_id      = "${module.vpc.vpc_id}"

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["ssh-tcp", "ssh-tcp-div", "all-icmp","knockd1-tcp","knockd2-tcp","knockd3-tcp"]
  egress_rules        = ["all-all"]
}

module "ec2_bastion" {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-ec2-instance.git"

  name                        = "Bastion"
  ami                         = "${data.aws_ami.amazon_linux.id}"
  #count                       = 1
  instance_type               = "t2.micro"
  key_name                    = "${var.ec2_user_key}"
  monitoring                  = true
  subnet_id                   = "${module.vpc.public_subnets[0]}"
  vpc_security_group_ids      = ["${module.security_group_bastion.this_security_group_id}"]
  associate_public_ip_address = true
  user_data                   = <<HEREDOC
#!/bin/bash

# Install ansible, knockd, and start iptables as a service.
# d.mckeon
yum-config-manager --enable epel
sleep 5
yum install ansible -y
yum install yum-python26.noarch -y
yum install fail2ban -y
yum install libpcap* -y
wget http://li.nux.ro/download/nux/dextop/el7/x86_64//knock-server-0.7-2.el7.nux.x86_64.rpm

rpm -ihv knock-server-0.7-2.el7.nux.x86_64.rpm

# Enable IPTABLES Firewall
service iptables start
chkconfig iptables on
cd /opt
wget https://gitlab.diversey.com/s04974/bastion-public-file/raw/master/bastion
unzip -P diversey2018 bastion
tar -xf bastion_zip.tar 
cd bastion_zip/
ansible-playbook bastion_knockd.yaml >output.txt
crontab -l >/tmp/root.tab
echo "*/15 * * * *  if ! out=\`/usr/bin/ansible-playbook /opt/bastion_zip/bastion_knockd.yaml >/tmp/ansible.output.txt\`; then echo $out; fi " >>/tmp/root.tab
crontab /tmp/root.tab

HEREDOC

	  tags = {
			    Terraform = "true"
			    Environment = "dev"
		 }
		 
  
}


