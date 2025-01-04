resource "aws_nat_gateway" "main" {
  count = length(var.cidr_numeral_public)
  subnet_id = element(aws_subnet.public.*.id, count.index)
  connectivity_type = "public"
  allocation_id = element(aws_eip.nat_gateway.*.id, count.index)

  tags = {
    Name = "nat-gw-${count.index}-${var.vpc_name}"
  }
}