resource "aws_key_pair" "terraform-deployer" {
  key_name   = "${var.deployer-key-name}"
  public_key = "${var.deployer-key}"
}

resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.SAS.id}"

  tags {
    Name = "${var.environment} - SAS"
  }
}

resource "aws_route" "bastion_host_to_internet" {
  depends_on = [
    "aws_route_table.public",
  ]

  route_table_id         = "${aws_route_table.public.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.PUBLIC-gw.id}"
}

resource "aws_route_table_association" "public" {
  subnet_id      = "${aws_subnet.PUBLIC.id}"
  route_table_id = "${aws_route_table.public.id}"
}

resource "aws_instance" "bastion_host" {
  ami                         = "${lookup(var.rhel_amis, var.region)}"
  instance_type               = "${lookup(var.bastion_instance_size, var.environment)}"
  count                       = "1"
  subnet_id                   = "${aws_subnet.PUBLIC.id}"
  vpc_security_group_ids      = ["${aws_security_group.bastion.id}"]
  associate_public_ip_address = true
  key_name                    = "${var.deployer-key-name}"

  tags {
    Name        = "bastion host"
    Environment = "SAS"
  }
}
