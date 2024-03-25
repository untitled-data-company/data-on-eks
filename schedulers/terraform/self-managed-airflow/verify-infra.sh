mv ~/.kube/config ~/.kube/config.bk
aws eks update-kubeconfig --region us-west-2 --name self-managed-airflow

aws eks describe-cluster --name self-managed-airflow --region us-west-2
kubectl get pvc -n airflow
kubectl get pv -n airflow
aws efs describe-file-systems --query "FileSystems[*].FileSystemId" --output text --region us-west-2
aws s3 ls --region us-west-2 | grep airflow-logs-
kubectl get deployment -n airflow

kubectl get ingress -n airflow
