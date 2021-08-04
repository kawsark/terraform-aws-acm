variable "hostname" {
    description = "The FQDN, such as my-tfe.hashidemos.io"
}

variable "route53_zone" {
    description = "The zone under route53 where this hostname will be defined"
    default = "hashidemos.io"
}

variable "tags" {
    default = {
        Environment = "dev"
        owner = "se@hashicorp.com"
        ttl = "48h"
    }
  }