variable "aws_profile" {
  default = "default"
}

variable "env" {
  default = "test"
}

variable "vpc_cidr" {
  default = "10.150.0.0/22"
}
variable "public_subnets_cidr" {
    default = [ "10.150.0.0/24", "10.150.1.0/24" ]
}

variable "private_subnets_cidr" {
    default = [ "10.150.2.0/24", "10.150.3.0/24" ]  
}

variable "availability_zones" {
    default = ["ap-south-1a","ap-south-1b"] 
  
}

variable "server-name" {
  default = "splunk"
}