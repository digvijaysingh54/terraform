resource "aws_instance" "digvijay" {
  ami           = var.ami
  instance_type = var.instance_type

  tags = {
    Name = var.tags_name
  }
}
