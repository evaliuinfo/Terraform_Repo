output "instance_id" {
  description = "EC2 instance ID"
  value       = aws_instance.test_instance.id
}

output "asg_id" {
  description = "Auto Scaling Group ID"
  value       = aws_autoscaling_group.test_asg.id
}
