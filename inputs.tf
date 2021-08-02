
# required in module invocation
variable "name" {
  description = "of security group"
  type        = string
}

variable "vpc_id" {
  description = "VPC of security group"
  type        = string
}
# end required var.s

variable "create_it" {
  description = "create or no?"
  type        = bool
  default     = true
}

# unlikely to survive, given *gress_rules reorg...
variable "source_cidr" {
  description = "cidr to limit ingrress (if used, typically home router IP/range, etc.)"
  type        = string
  default     = "0.0.0.0/0"
}

variable "shared_sg" {
  description = "flag to enable creation of Shared tag to security group"
  type        = bool
  default     = false
}

variable "sg_tags" {
  description = "A mapping of tags to assign to security group"
  type        = map(string)
  default     = {}
}

variable "num_ingress_rules" {
  description = "workaround for terraform unwilling to allow formulas in var init.s"
  type        = number
  default     = 0
}

variable "ingress_rules" {
  description = "list of ingress rule names, looked up from rules map"
  type        = list(list(string))
  default     = []
}

variable "num_egress_rules" {
  description = "workaround for terraform unwilling to allow formulas in var init.s"
  type        = number
  default     = 0
}

variable "egress_rules" {
  description = "list of egress rule names, looked up from rules map"
  type        = list(list(string))
  default     = []
}

variable "tags" {
  description = "what it says"
  type        = map(string)
}

