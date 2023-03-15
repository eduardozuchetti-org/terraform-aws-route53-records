resource "aws_route53_record" "records" {
  for_each = {
    for key, value in var.records: key => value
      if lower(lookup(value, "use_lifecycle", "")) != "ignore_changes_records" 
        && lower(var.use_lifecycle) != "ignore_changes_records"
  }

  zone_id                             = each.value.zone_id
  name                                = each.value.name
  type                                = each.value.type
  ttl                                 = each.value.ttl
  records                             = each.value.records
  set_identifier                      = each.value.set_identifier
  health_check_id                     = each.value.health_check_id
  multivalue_answer_routing_policy    = each.value.multivalue_answer_routing_policy
  allow_overwrite                     = each.value.allow_overwrite


  dynamic "alias" {
    for_each = lookup(each.value, "alias", null) != null ? [1] : []

    content {
      name                   = each.value.alias.name
      zone_id                = each.value.alias.zone_id
      evaluate_target_health = lookup(each.value.alias, "evaluate_target_health", false) 
    }
  }

  #  dynamic "cidr_routing_policy" {
  #    for_each = lookup(each.value, "cidr_routing_policy", null) != null ? [1] : []
  #
  #    content {
  #      collection_id = each.value.cidr_routing_policy.collection_id
  #      location_name = each.value.cidr_routing_policy.location_name
  #    }
  #  }

  dynamic "failover_routing_policy" {
    for_each = lookup(each.value, "cidr_routing_policy", null) != null ? [1] : []

    content {
      type  = each.value.failover_routing_policy.type
    }
  }

  dynamic "geolocation_routing_policy" {
    for_each = lookup(each.value, "geolocation_routing_policy", null) != null ? [1] : []

    content {
      continent   = each.value.geolocation_routing_policy.continent
      country     = each.value.geolocation_routing_policy.country
      subdivision = each.value.geolocation_routing_policy.subdivision
    }
  }

  dynamic "latency_routing_policy" {
    for_each = lookup(each.value, "latency_routing_policy", null) != null ? [1] : []

    content {
      region  = each.value.latency_routing_policy.region
    }
  }

  dynamic "weighted_routing_policy" {
    for_each = lookup(each.value, "weighted_routing_policy", null) != null ? [1] : []

    content {
      weight  = each.value.weighted_routing_policy.weight
    }
  }
}

resource "aws_route53_record" "records_with_lifecycle" {
  for_each = {
    for key, value in var.records: key => value
      if lower(lookup(value, "use_lifecycle", "")) == "ignore_changes_records" 
        || lower(var.use_lifecycle) == "ignore_changes_records"
  }

  zone_id                             = each.value.zone_id
  name                                = each.value.name
  type                                = each.value.type
  ttl                                 = each.value.ttl
  records                             = each.value.records
  set_identifier                      = each.value.set_identifier
  health_check_id                     = each.value.health_check_id
  multivalue_answer_routing_policy    = each.value.multivalue_answer_routing_policy
  allow_overwrite                     = each.value.allow_overwrite


  dynamic "alias" {
    for_each = lookup(each.value, "alias", null) != null ? [1] : []

    content {
      name                   = each.value.alias.name
      zone_id                = each.value.alias.zone_id
      evaluate_target_health = lookup(each.value.alias, "evaluate_target_health", false) 
    }
  }

  #  dynamic "cidr_routing_policy" {
  #    for_each = lookup(each.value, "cidr_routing_policy", null) != null ? [1] : []
  #
  #    content {
  #      collection_id = each.value.cidr_routing_policy.collection_id
  #      location_name = each.value.cidr_routing_policy.location_name
  #    }
  #  }

  dynamic "failover_routing_policy" {
    for_each = lookup(each.value, "cidr_routing_policy", null) != null ? [1] : []

    content {
      type  = each.value.failover_routing_policy.type
    }
  }

  dynamic "geolocation_routing_policy" {
    for_each = lookup(each.value, "geolocation_routing_policy", null) != null ? [1] : []

    content {
      continent   = each.value.geolocation_routing_policy.continent
      country     = each.value.geolocation_routing_policy.country
      subdivision = each.value.geolocation_routing_policy.subdivision
    }
  }

  dynamic "latency_routing_policy" {
    for_each = lookup(each.value, "latency_routing_policy", null) != null ? [1] : []

    content {
      region  = each.value.latency_routing_policy.region
    }
  }

  dynamic "weighted_routing_policy" {
    for_each = lookup(each.value, "weighted_routing_policy", null) != null ? [1] : []

    content {
      weight  = each.value.weighted_routing_policy.weight
    }
  }

  lifecycle {
    ignore_changes = [
      records
    ]
  }
}