resource "terraform_data" "copy_index" {
  count = length(var.cidr_numeral_public)

  connection {
    type = "ssh"
    user = "ec2-user"
    host = element(aws_eip.public_ec2.*.public_ip, count.index)
    private_key = tls_private_key.ec2_private_key.*.private_key_pem[0]
  }

  provisioner "remote-exec" {
    inline = [
      "while [ ! -d /var/www/html ]; do sleep 5; done",
      "echo '/var/www/html is ready'",
      "sudo chmod 755 /var/www/html",
      "sudo chown ec2-user:ec2-user /var/www/html",
    ]
  }

  provisioner "file" {
    source = "${path.module}/index.php"
    destination = "/var/www/html/index.php"
  }
}