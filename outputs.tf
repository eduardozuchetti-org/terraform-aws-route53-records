output "aws_route53_records" {
  value = concat(aws_route53_record.records, aws_route53_record.records_with_lifecycle)

}