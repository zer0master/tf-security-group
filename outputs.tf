#

output "sg_id" {
  description = "what you'd expect"
  value = concat(
    aws_security_group.defined.*.id,
    [""],
  )[0]
  # remember to add other types of "*.id" as they're supported
}

output "vpc_id" {
  description = "what you'd expect"
  value = concat(
    aws_security_group.defined.*.vpc_id,
    [""],
  )[0]
}

output "name_id_map" {
  description = "lookup security group id's if name known"
  value = "${zipmap(aws_security_group.defined.*.tags.Name, aws_security_group.defined.*.id)}"
}
