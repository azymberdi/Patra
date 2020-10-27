# Patra

Table of Contents
main.tf - includes the necessary Terraform configuration to install Autoscaling group with 2 instances that will run with Grafana, Prometheus and Node Explorer.
Jenkinsfile - includes necessary Jenkins configuration to automate it

Prerequisites
![alt text](https://user-images.githubusercontent.com/57076637/96326823-14361600-1002-11eb-9281-fccafa0c5b92.png)

Terraform without Jenkins

Since the AWS Access and Secret Keys are installed inside Credential Configurations, to run Terraform code by itself tfvars file for Configurations is manadatory to be created. Credentials.tfvars, that was git ignored for security purposes, must include:

```
access_key = ""
secret_key = ""
```

Inside the Directory, run:
```
terraform init
terraform plan -var-file=credentials.tfvars
```
Finally, if you are satisifed with the outcome

```
terraform apply -var-file=credentials.tfvars. 
```
