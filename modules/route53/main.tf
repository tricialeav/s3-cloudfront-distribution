data "aws_route53_zone" "this" {
  name = var.route53_zone_name
}

resource "aws_route53_record" "this" {
  count   = length(var.route53_records)
  zone_id = data.aws_route53_zone.this.zone_id
  name    = var.route53_records[count.index].name
  type    = var.route53_records[count.index].type
  alias {
    name                   = var.route53_records[count.index].alias.name
    zone_id                = var.route53_records[count.index].alias.zone_id
    evaluate_target_health = var.route53_records[count.index].alias.evaluate_target_health
  }
}