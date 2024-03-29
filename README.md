# Airflow on EKS

[Based on Data on EKS blueprint](https://awslabs.github.io/data-on-eks/docs/blueprints/job-schedulers/self-managed-airflow)

## Deployment
```shell
./install.sh
```

Connect `kubectl`
```shell
mv ~/.kube/config ~/.kube/config.backup
aws eks update-kubeconfig --region us-east-1 --name self-managed-airflow
```

Deploy the secret to pull private github docker images which will be executed by Airflow on Kubernetes:
```shell
kubectl create secret docker-registry ghcr-login-secret --docker-server=https://ghcr.io --docker-username=francescomucio --docker-password=ghp_TODO --docker-email=mucio@mucio.net -n airflow
```
|flag | meaning|
|-----| ------ |
| --docker-username | the github username. Can be a machine user |
| --docker-password | the github personal access token |
| --docker-email    | the github email ID |


Verify the deployment:
```shell
mv ~/.kube/config ~/.kube/config.bk
aws eks update-kubeconfig --region us-east-1 --name self-managed-airflow

aws eks describe-cluster --name self-managed-airflow --region us-east-1
kubectl get pvc -n airflow
kubectl get pv -n airflow
aws efs describe-file-systems --query "FileSystems[*].FileSystemId" --output text --region us-east-1
aws s3 ls --region us-east-1 | grep airflow-logs-
kubectl get deployment -n airflow
```

## Set Up DAG Git Repository
This deployment uses git-sync in a sidecar container. It polls a github repository for DAG changes which can be configured in [helm-values/airflow-values.yaml].
- Set `repo:` to `git@github.com:MyOrganization/my-dag-repo.git`.
- Set `airflow-ssh-secret:` to authenticate to a private github repository using an SSH key. Paste the private key in base64 encoding.

## Connect to Airflow GUI Webserver
Get the public url of the Airflow deployment:
```shell
kubectl get ingress -n airflow
```


## Delete all Infrastructure
```shell
./cleanup.sh
```


## Support
Monitor and use the [Issues](https://github.com/awslabs/data-on-eks/issues)
