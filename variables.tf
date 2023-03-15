variable "records" {
    type = map(object({
        use_lifecycle                       = optional(string)
        zone_id                             = string
        name                                = string
        type                                = string
        ttl                                 = optional(string)
        records                             = optional(list(string))
        set_identifier                      = optional(string)
        health_check_id                     = optional(string)
        multivalue_answer_routing_policy    = optional(bool)
        allow_overwrite                     = optional(bool)

        alias = optional(object({
            name                    = string
            zone_id                 = string
            evaluate_target_health  = string
        }))

        cidr_routing_policy = optional(object({
            collection_id   = string
            location_name   = string
        }))

        failover_routing_policy = optional(object({
            type = string
        }))

        geolocation_routing_policy = optional(object({
            continent   = string
            country     = string
            subdivision = string
        }))

        latency_routing_policy = optional(object({
            region = string
        }))

        weighted_routing_policy = optional(object({
            weight = string
        }))

    }))

    description = "(Requires) Map of objects for each record"
}

variable "use_lifecycle" {
    type        = string
    description = "(optional) Apply Lifecycle on all resources. Ex. \"ignore_changes_routes\""
    default     = "managed"
}