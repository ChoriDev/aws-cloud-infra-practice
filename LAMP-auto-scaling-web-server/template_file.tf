data "template_file" "dbinfo" {
  template = <<-EOT
  <?php
  define('DB_SERVER', '${aws_db_instance.rds_rr.address}');
  define('DB_USERNAME', '${aws_db_instance.rds.username}');
  define('DB_PASSWORD', '${aws_db_instance.rds.password}');
  define('DB_DATABASE', '${aws_db_instance.rds.db_name}');
  ?>
  EOT
}

resource "local_file" "dbinfo_file" {
  content  = data.template_file.dbinfo.rendered
  filename = "${path.module}/dbinfo.inc"
}
