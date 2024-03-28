output "configure_kubectl" {
  description = "Configure kubectl: make sure you're logged in with the correct AWS profile and run the following command to update your kubeconfig"
  value       = "aws eks --region ${var.region} update-kubeconfig --name ${var.name}"
}

output "s3_bucket_id_airflow_logs" {
  description = "Airflow logs S3 bucket ID"
  value       = try(module.airflow_s3_bucket[0].s3_bucket_id, "")
}
