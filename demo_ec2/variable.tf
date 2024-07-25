variable "ami" {
  description = "ami id"
  type        = string
  default     = "ami-0b72821e2f351e396"
}

variable "instance_type" {
  description = "Name to be used on EC2 instance created"
  type        = string
  default     = "t2.micro"
}

variable "tags_name" {
  description = "Name to be used on EC2 instance created"
  type        = string
  default     = "Web-Server"
}