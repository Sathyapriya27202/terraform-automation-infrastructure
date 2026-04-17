# Terraform Azure Infrastructure Project

## 📌 Overview
This project provisions Azure infrastructure using Terraform with modular architecture.

## 🚀 Features
- Modular design
- Resource Group & Subnet creation
- Input validation
- Tagging strategy
- Remote state backend

## 📂 Structure
terraform-azure-project/
│── main.tf
│── variables.tf
│── outputs.tf
│── providers.tf
│── backend.tf
│── modules/

## ▶️ Usage
terraform init  
terraform plan  
terraform apply  

## 🔐 Best Practices
- State file excluded
- Validation added
- Reusable modules