resource "aws_vpc" "my_vpc" {
  cidr_block           = "11.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "my-vpc"
    Environment = var.env
  }
}

resource "aws_internet_gateway" "my_vpc_igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "my-vpc-igw"
  }
}

resource "aws_subnet" "public_sub_1a" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "11.0.1.0/24"
  availability_zone       = "${var.aws_region}a"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-1a"
  }
}

resource "aws_subnet" "public_sub_1b" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "11.0.2.0/24"
  availability_zone       = "${var.aws_region}b"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-1b"
    }
}

resource "aws_subnet" "private_subnet_1a" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "11.0.3.0/24"
  availability_zone       = "${var.aws_region}a"
  map_public_ip_on_launch = false

  tags = {
    Name = "private-subnet-1a"
    }
}

resource "aws_subnet" "private_subnet_1b" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "11.0.4.0/24"
  availability_zone       = "${var.aws_region}b"
  map_public_ip_on_launch = false

  tags = {
    Name = "private-subnet-1b"
    }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_vpc_igw.id
  }

  tags = {
    Name = "public-rt"
  }
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "private-rt"
  }
}

resource "aws_route_table_association" "public_rt_as1" {
  subnet_id      = aws_subnet.public_sub_1a.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_rt_as2" {
  subnet_id      = aws_subnet.public_sub_1b.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "private_rt_as1" {
  subnet_id      = aws_subnet.private_subnet_1a.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private_rt_as2" {
  subnet_id      = aws_subnet.private_subnet_1b.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_security_group" "my_vpc_sg" {
  vpc_id          = aws_vpc.my_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "my-vpc-sg"
  }
}
