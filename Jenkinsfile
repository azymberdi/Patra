properties([
    parameters([
        booleanParam(defaultValue: false, description: 'Please select to apply changes', name: 'terraformApply'), 
        booleanParam(defaultValue: false, description: 'Please select it to destroy a previously created job.', name: 'terraformDestroy'),
        choice(choices: ['us-east-1','us-west-2', 'us-west-1', 'us-east-2', 'eu-west-1'], description: 'Please select the region', name: 'aws_region'),
    ])
])

pipeline {
    agent any
    tools {
        "org.jenkinsci.plugins.terraform.TerraformInstallation" "terraform-0.11.8"
    }
  
    environment {
        TF_HOME = tool('terraform-0.11.8')
        TF_IN_AUTOMATION = "true"
        PATH = "$TF_HOME:$PATH"
        ACCESS_KEY = credentials('AWS_ACCESS_KEY_ID')
        SECRET_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }
    stages {
            stage('TerraformInit'){
               println("Initiating ...")
               sh """
               #!/bin/bash
               terraform init -input=false
               echo \$PWD
               whoami
               """
                }
            }

            stage("Terraform Apply/Plan") {
                    if (!params.terraformDestroy) {
                    if (params.terraformApply) {
                    println("Applying the changes")
                    sh """
                    #!/bin/bash
                    export AWS_DEFAULT_REGION=${aws_region}
                    terraform apply -var 'access_key=$ACCESS_KEY' -var 'secret_key=$SECRET_KEY'
                    """
                } else {
                    println("Planning the changes")
                    sh """
                    #!/bin/bash
                    export AWS_DEFAULT_REGION=${aws_region}
                    terraform plan -var 'access_key=$ACCESS_KEY' -var 'secret_key=$SECRET_KEY'
                    """
                }
            }
            stage("Terraform Destroy") {
                        if (params.terraformDestroy) {
                            println("Destroying all")
                            sh """
                            #!/bin/bash
                            export AWS_DEFAULT_REGION=${aws_region}
                            terraform destroy -var 'access_key=$ACCESS_KEY' -var 'secret_key=$SECRET_KEY'
                            """
                        } else {
                            println("Skipping the destroy")
                   }
              }
         }
    } 
