pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID     = credentials('aws_cred')  // Replace with your Jenkins credential ID
        AWS_SECRET_ACCESS_KEY = credentials('aws_cred')  // Replace with your Jenkins credential ID
    }

    stages {
        stage('Clone repository') {
            steps {
                git 'https://github.com/santoshbd67/Terraform-Jenkins.git'  // Replace with your repo URL
            }
        }
        stage('Initialize Terraform') {
            steps {
                sh 'terraform init'
            }
        }
        stage('Plan Terraform') {
            steps {
                sh 'terraform plan -var-file="stage.tfvars"'
            }
        }
        stage('Apply Terraform') {
            steps {
                sh 'terraform apply -var-file="stage.tfvars" -auto-approve'
            }
        }
        stage('destroy Terraform') {
            steps {
                sh 'terraform destroy -auto-approve'
            }
        }
    }
}
