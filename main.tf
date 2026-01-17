# VPC 

resource "aws_vpc" "main" {
    cidr_block           = "10.0.0.0/16"
    enable_dns_hostnames = true
    enable_dns_support   = true
    tags = {
        Name = "learning-vpc"
    }
}
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.main.id

    tags = {
        Name = "learning-igw"
    }
}

resource "aws_subnet" "public" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.10.0/24"
    avaiability_zone = "us-east-1"
    map_public_ip_on_launch = true

    tags = {
        Name = "public-subnet"
    }
}

resource "aws_route_table" "public" {
    vpc_id = aws_vpc.main.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }

    tags = {
        Name = "public-rt"
    }
}

resource "aws_route_table_association" "public_assoc" {
    subnet_id = aws_subnet.public.id
    route_table_id = aws_route_table.public.id
}
