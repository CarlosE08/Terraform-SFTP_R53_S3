# Terraform AWS SFTP Infrastructure

This Terraform project provisions an SFTP server over AWS Transfer Family, integrated with Amazon S3 and managed via a Route 53 Hosted Zone. It is designed with a modular approach for clarity, scalability, and reuse.

## 📦 Project Structure

```
project-root/
├── main.tf              # Root configuration invoking modules
├── variables.tf         # Input variables for the root module
├── terraform.tfvars     # Environment-specific variable values
└── modules/             # Modular components for each AWS service
    ├── IAM/             # IAM roles and policies for SFTP access
    ├── S3/              # S3 bucket as the SFTP backend
    ├── SFTP/            # AWS Transfer Family (SFTP) server setup
    └── Route53/         # DNS records for SFTP endpoint
```

## 🧩 Modules Overview

Each module is self-contained and includes:
- `*_aws.tf`: Resource definitions for a specific AWS service.
- `variables.tf`: Module input variables.
- `outputs.tf`: Module outputs to be consumed by root or other modules.

## 🚀 Usage

1. Initialize Terraform:
   ```bash
   terraform init
   ```

2. Preview changes:
   ```bash
   terraform plan
   ```

3. Deploy the infrastructure:
   ```bash
   terraform apply
   ```

## ✅ Key Features

- Deploys a **fully managed SFTP server** on AWS Transfer Family.
- Integrates with **Amazon S3** as the storage backend.
- Uses **Route 53** for custom domain mapping.
- Modular architecture promotes **clean separation of services**.

---

Perfect for teams needing a secure, scalable, and DNS-mapped SFTP solution in AWS.
