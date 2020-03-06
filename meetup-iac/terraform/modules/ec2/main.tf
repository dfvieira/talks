resource "aws_instance" "this" {
  ami                         = "${var.ec2_ami}"
  instance_type               = "${var.ec2_instance_type}"
  key_name                    = "${var.ec2_key}"
  monitoring                  = "${var.ec2_monitoring}"
  subnet_id                   = "${var.ec2_subnet_id}"
  associate_public_ip_address = "${var.ec2_associate_public_ip}"

  ## Criar EC2 com ENI especifica
  # network_interface {
  #   device_index         = 0
  #   network_interface_id = "${var.ec2_network_interface}"
  # }

  tags = "${merge(map("Name", format("%s", var.ec2_name)), var.tags)}"
}
