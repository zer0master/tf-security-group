# create one security group with tags; caller responsible for suffix and common tags

locals {
  defined_sg_id = concat(
    aws_security_group.defined.*.id,
    [""],
  )[0]
}

resource "aws_security_group" "defined" {
  count = var.create_it ? 1 : 0

  name                    = var.name
  vpc_id                  = var.vpc_id
  revoke_rules_on_delete  = true

  tags = merge(
    var.tags,
    { Name = var.name,
      Shared = var.shared_sg ? "yes" : null
    })
  # when shared_sg is false, Shared tag not added at all (+1)
}

resource "aws_security_group_rule" "incoming" {
  count = var.create_it ? var.num_ingress_rules : 0

  security_group_id = local.defined_sg_id
  type              = "ingress"

  # match structure of var.rules default content (number, number, string, string)
  from_port   = var.rules[var.ingress_rules[count.index][0]][0]
  to_port     = var.rules[var.ingress_rules[count.index][0]][1]
  protocol    = var.rules[var.ingress_rules[count.index][0]][2]
  description = var.rules[var.ingress_rules[count.index][0]][3]
  cidr_blocks = flatten(
                  regexall(
                    "((?:\\d{1,3}\\.){3}(?:\\d{1,3})/\\d{1,2})",  # w.x.y.z/n ... (any non IP cidr delimiter allowed)
                    var.ingress_rules[count.index][1]))
}

resource "aws_security_group_rule" "outgoing" {
  count = var.create_it ? var.num_egress_rules : 0

  security_group_id = local.defined_sg_id
  type              = "egress"

  from_port   = var.rules[var.egress_rules[count.index][0]][0]
  to_port     = var.rules[var.egress_rules[count.index][0]][1]
  protocol    = var.rules[var.egress_rules[count.index][0]][2]
  description = var.rules[var.egress_rules[count.index][0]][3]
  cidr_blocks = flatten(
                  regexall(
                    "((?:\\d{1,3}\\.){3}(?:\\d{1,3})/\\d{1,2})",  # w.x.y.z/n ... (any non IP cidr delimiter allowed)
                    var.egress_rules[count.index][1]))
}

#NOTE: support other variations of rule creation in future (prefix-lists, etc.)

