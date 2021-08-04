This simple terraform module provisions an AWS ACM certificate and verifies it using a Route 53 DNS record

### How to use
- Adjust the following variables as needed
  - `hostname`: The FQDN that will be the Subject for the ACM Certificate
  - `route53_zone`: The Route 53 Zone where the validation DNS record will be defined
  - Adjust the `tags` variable as needed
- Set [AWS Provider credentials and Region](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#environment-variables) environment variables
- Run `terraform plan` and `terraform apply`

