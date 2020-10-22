# Patra

Inside the Directory, run:
```
terraform init
terraform plan -var-file=credentials.tfvars
```
Finally, if you are satisifed with the outcome

```
terraform apply -var-file=credentials.tfvars. 
```
Credentials.tfvars, that was git ignored for security purposes, must include:

```
access_key = ""
secret_key = ""
```
