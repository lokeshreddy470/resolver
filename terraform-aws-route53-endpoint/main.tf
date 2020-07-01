resource "aws_route53_resolver_endpoint" "resolver_endpoint" {
  direction          = upper(var.direction)
  security_group_ids = var.security_groups
  tags               = var.tags

  dynamic "ip_address" {
    for_each = var.ip_addresses

    content {
      ip        = lookup(ip_address.value, "ip", null)
      subnet_id = ip_address.value.subnet_id
    }
  }

}
