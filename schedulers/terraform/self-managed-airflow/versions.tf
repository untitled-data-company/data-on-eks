terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.43"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.27.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.12.1"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.14"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }
  }

  ##  Used for end-to-end testing on project; update to suit your needs
  backend "s3" {
    bucket = "untitled-data-company-tf-states"
    region = "eu-central-1"
    key    = "e2e/self-managed-airflow/terraform.tfstate"
  }
}
