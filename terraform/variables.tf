variable "ec2_ami" {
    type = map

  default = {
    us-east-1 = "ami-02396cdd13e9a1257"
   }
 }
variable "region" {
  default = "us-east-1"
}
variable "instance_type" {
  default = "t2.micro"
}
