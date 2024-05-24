resource "aws_route53_record" "www" {
  zone_id = var.zone_id
  name    = var.dns_name
  type    = "CNAME"
  ttl     = 300
  records = [aws_lb.lb.dns_name]
}

