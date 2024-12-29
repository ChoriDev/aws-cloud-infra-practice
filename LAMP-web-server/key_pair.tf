# Create a PEM formatted private key
resource "tls_private_key" "ec2_private_key" {
  algorithm = "RSA"
  rsa_bits = 4096
}

# EC2 Key Pair
resource "aws_key_pair" "ec2_key_pair" {
  key_name = "ec2_key_pair"
  public_key = tls_private_key.ec2_private_key.public_key_openssh
}

# Generate a local file with private key
resource "local_file" "ec2_key" {
  filename = "ec2_key_pair.pem"
  content = tls_private_key.ec2_private_key.private_key_pem
}