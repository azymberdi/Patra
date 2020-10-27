# Patra

Table of Contents
main.tf - includes the necessary Terraform configuration to install Autoscaling group with 2 instances that will run with Grafana, Prometheus and Node Explorer.  
Jenkinsfile - includes necessary Jenkins configuration to automate it. 
  
Prerequisites
These programs need to be installed in your Machine.
Terraform v0.11.8
Jenkins - The provided link can be used: https://linuxize.com/post/how-to-install-jenkins-on-centos-7/

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
