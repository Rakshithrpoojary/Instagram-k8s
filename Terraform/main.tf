

data "aws_vpc" "insta_vpc" {
  filter {
    name   = "tag:Name"
    values = ["Rakshith"]
  }
}

resource "aws_subnet" "insta-subnet" {
  vpc_id                  = data.aws_vpc.insta_vpc.id
  cidr_block              = var.subnet.cidr
  availability_zone       = var.subnet.availability_zone
  tags                    = var.subnet.tags
  map_public_ip_on_launch = true
}

resource "aws_security_group" "sg" {
  vpc_id   = data.aws_vpc.insta_vpc.id
  for_each = var.sg
  name     = each.key
  dynamic "ingress" {
    for_each = each.value
    content {
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = "tcp"
      cidr_blocks = [ingress.value.cidr]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_internet_gateway" "insta_igw" {
  vpc_id = data.aws_vpc.insta_vpc.id
  tags = {
    Name = "Insta_igw"
  }

}
resource "aws_route_table" "insta_rt" {
  vpc_id = data.aws_vpc.insta_vpc.id
  tags = {
    Name = "Insta_rt"
  }
}

resource "aws_route" "insta_rts" {
  route_table_id         = aws_route_table.insta_rt.id
  gateway_id             = aws_internet_gateway.insta_igw.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table_association" "insta_rt_assoc" {
  route_table_id = aws_route_table.insta_rt.id
  subnet_id      = aws_subnet.insta-subnet.id
}
resource "aws_instance" "instance" {
  for_each               = var.instance
  ami                    = each.value.ami
  instance_type          = each.value.type
  subnet_id              = aws_subnet.insta-subnet.id
  key_name               = "jenkins-key"
  vpc_security_group_ids = [aws_security_group.sg[each.value.sg].id]
  root_block_device {
    volume_size = each.value.storage
    volume_type = each.value.storagetype
  }
  tags = each.value.tags
}
