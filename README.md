# Patra

## Table of Contents. 
**main.tf** - includes the necessary Terraform configuration to install Autoscaling group with 2 instances that will run with Grafana, Prometheus and Node Explorer.  
**Jenkinsfile** - includes necessary Jenkins configuration to automate it. 
  
**userdata.sh** - includes the shell commands to install Grafana, Prometheus and Node Explorer inside the newly created Machine.
  
## Prerequisites

### Terraform v0.11.8.    
Steps for installing Terraform on your machine:   
```
sudo yum install wget -y
sudo yum install unzip -y
sudo wget  https://releases.hashicorp.com/terraform/0.11.14/terraform_0.11.14_linux_amd64.zip
sudo unzip terraform_0.12.24_linux_amd64.zip 
sudo mv terraform /bin
rm -rf terraform_0.12.24_linux_amd64.zip
```
### Jenkins    
The provided link can be used to install Jenkins: https://linuxize.com/post/how-to-install-jenkins-on-centos-7/.     


## Applying Terraform code without Jenkins

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
