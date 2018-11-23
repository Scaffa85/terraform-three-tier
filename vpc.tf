#VPC Setup / Subnets / EIP

resource "aws_vpc" "SAS" {
  cidr_block = "${cidrsubnet(var.cidr_range, 8, 0)}"

  tags {
    Name = "${var.environment} - SAS"
  }
}

resource "aws_eip" "nat_eip_SAS_9_4" {}
resource "aws_eip" "nat_eip_VIYA" {}
resource "aws_eip" "nat_eip_HPAE" {}

# Public Networking Objects
resource "aws_subnet" "PUBLIC" {
  vpc_id                  = "${aws_vpc.SAS.id}"
  cidr_block              = "${cidrsubnet(aws_vpc.SAS.cidr_block, 8, 10)}"
  availability_zone       = "${data.aws_availability_zones.current.names[0]}"
  map_public_ip_on_launch = true

  tags {
    Name = "${var.environment} - SAS 9.4"
  }
}

resource "aws_internet_gateway" "PUBLIC-gw" {
  vpc_id = "${aws_vpc.SAS.id}"

  tags {
    Name = "${var.environment} - SAS 9.4"
  }
}

# SAS 9.4 Networking Objects
resource "aws_subnet" "SAS_9_4" {
  vpc_id                  = "${aws_vpc.SAS.id}"
  cidr_block              = "${cidrsubnet(aws_vpc.SAS.cidr_block, 8, 1)}"
  availability_zone       = "${data.aws_availability_zones.current.names[0]}"
  map_public_ip_on_launch = false

  tags {
    Name = "${var.environment} - SAS 9.4"
  }
}

resource "aws_route_table" "SAS_9_4_route_table" {
  vpc_id = "${aws_vpc.sas.id}"

  tags {
    Name = "${var.environment} - SAS_9_4"
  }
}

resource "aws_route" "SAS_9_4_to_internet" {
  depends_on = [
    "aws_route_table.SAS_9_4_route_table",
  ]

  route_table_id         = "${aws_route_table.SAS_9_4_route_table.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.SAS_9_4_nat_gateway.id}"
}

resource "aws_nat_gateway" "SAS_9_4_nat_gateway" {
  subnet_id     = "${aws_subnet.SAS_9_4.id}"
  depends_on    = ["aws_internet_gateway.PUBLIC-gw"]
  allocation_id = "${aws_eip.nat_eip_SAS_9_4.id}"

  tags {
    Name = "${var.environment} - SAS 9.4"
  }
}

# SAS VIYA Networking Objects
resource "aws_subnet" "SAS_VIYA" {
  vpc_id                  = "${aws_vpc.SAS.id}"
  cidr_block              = "${cidrsubnet(aws_vpc.SAS.cidr_block, 8, 2)}"
  availability_zone       = "${data.aws_availability_zones.current.names[0]}"
  map_public_ip_on_launch = false

  tags {
    Name = "${var.environment} - SAS VIYA"
  }
}

resource "aws_route_table" "SAS_VIYA_route_table" {
  vpc_id = "${aws_vpc.sas.id}"

  tags {
    Name = "${var.environment} - SAS VIYA"
  }
}

resource "aws_nat_gateway" "SAS_VIYA_nat_gateway" {
  subnet_id     = "${aws_subnet.SAS_VIYA.id}"
  depends_on    = ["aws_internet_gateway.PUBLIC-gw"]
  allocation_id = "${aws_eip.nat_eip_VIYA.id}"

  tags {
    Name = "${var.environment} - SAS VIYA"
  }
}

# SAS HPAE Networking Objects
resource "aws_subnet" "SAS_HPAE" {
  vpc_id                  = "${aws_vpc.SAS.id}"
  cidr_block              = "${cidrsubnet(aws_vpc.SAS.cidr_block, 8, 3)}"
  availability_zone       = "${data.aws_availability_zones.current.names[0]}"
  map_public_ip_on_launch = false

  tags {
    Name = "${var.environment} - SAS HPAE"
  }
}

resource "aws_route_table" "SAS_HPAE_route_table" {
  vpc_id = "${aws_vpc.sas.id}"

  tags {
    Name = "${var.environment} - SAS HPAE"
  }
}

resource "aws_nat_gateway" "SAS_HPAE_nat_gateway" {
  subnet_id     = "${aws_subnet.SAS_HPAE.id}"
  depends_on    = ["aws_internet_gateway.PUBLIC-gw"]
  allocation_id = "${aws_eip.nat_eip_HPAE.id}"

  tags {
    Name = "${var.environment} - SAS HPAE"
  }
}
