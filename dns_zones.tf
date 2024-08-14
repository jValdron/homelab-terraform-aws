resource "aws_route53_zone" "int_valdron_ca" {
  name = "int.valdron.ca"
}

resource "aws_route53_zone" "valdron_ca" {
  name = "valdron.ca"
}

resource "aws_route53_zone" "valdron_net" {
  name = "valdron.net"
}

resource "aws_route53_zone" "omgflyball_com" {
  name = "omgflyball.com"
}
