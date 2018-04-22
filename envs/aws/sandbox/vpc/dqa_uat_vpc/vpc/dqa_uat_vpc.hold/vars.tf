variable "region" {
        default = "eu-west-1"
}
variable "profile" {
    description = "AWS credentials profile you want to use"
}
variable "ec2_user_key" {
    default = "dev_bastion_key"
    description = "AWS pub Key name"
}
variable "ec2_user_key_pub" {
    default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC5qaBLF09ilcHLS+CscyLD40bsLb1FdbcWnaIkb+V4YiQxuOKThxB/FP1PnfwqZ/XYqICQcbvXvHS9ejDhStnmJPj88c/VjdikX9dLEgZhodw4g7rX7n5adgyladVYqjD4VfALG4nzZGKdy/U41ZOT7o8aG2OpBAZ54aLnxCqOEBgYCZDKmAiLkZjJbyF1DR4JuoP+5SvWqeiMQcLOaqFA4foJ9owCg+bEmCzgwNpcfa3yLjp3dIi96tBouyRwH71x9S6Ss2yEcyTEpFaNqGWIiR8Im8l0NFUnYToPoAVrd4RzIS1l8oC+jdSF7k8gbM5vAVRkAu72lGfzhAg6i76R dev_bastion_key"
    description = "AWS pub Key"
}

