# Create a PEM formatted private key
resource "tls_private_key" "ec2_private_key" {
  count = 2
  algorithm = "RSA"
  rsa_bits = 4096
}

# Public ec2 key pair
resource "aws_key_pair" "public_ec2_key_pair" {
  key_name = "public_ec2_key_pair"
  public_key = tls_private_key.ec2_private_key[0].public_key_openssh
}

# Generate a local file about public ec2 key
resource "local_file" "public_ec2_key" {
  filename = "public_ec2_key_pair.pem"
  content = tls_private_key.ec2_private_key[0].private_key_pem
}

# Private ec2 key pair
resource "aws_key_pair" "private_ec2_key_pair" {
  key_name = "private_ec2_key_pair"
  public_key = tls_private_key.ec2_private_key[1].public_key_openssh
}

# Generate a local file about private ec2 key
resource "local_file" "private_ec2_key" {
  filename = "private_ec2_key_pair.pem"
  content = tls_private_key.ec2_private_key[1].private_key_pem
}