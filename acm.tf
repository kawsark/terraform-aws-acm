### Zone ID Data Source
data "aws_route53_zone" "pes" {
  name = var.route53_zone
 #private_zone = true for private zone
}


### Routing resources

# This allows ACM to validate the new certificate
resource "aws_route53_record" "cert_validation" {

  for_each = {
    for dvo in aws_acm_certificate.cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  name            = each.value.name
  records         = [each.value.record]
  type            = each.value.type
  zone_id = data.aws_route53_zone.pes.zone_id
  ttl     = 60
}

### Certificate resources

# Main ACM Cert
resource "aws_acm_certificate" "cert" {
  domain_name       = var.hostname
  validation_method = "DNS"
  tags = var.tags
}

# This allows ACM to validate the new certificate
resource "aws_acm_certificate_validation" "cert" {
  certificate_arn         = "${aws_acm_certificate.cert.arn}"
  validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]
}

output "arn" {
  value = "${aws_acm_certificate.cert.arn}"
}