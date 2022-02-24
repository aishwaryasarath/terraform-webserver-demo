# Terraform webserver demo
Create a web server using terraform

## Create and apply the terraform file to create the instance 
1. Create a terraform file to create the aws instance and give the bash script to install the http server after the instance is created
``` # tbd: create bootstrap script

user_data = <<-EOF
          #! /bin/bash
          sudo yum update -y
          sudo yum install httpd -y
          sudo systemctl start httpd
          sudo systemctl enable httpd
          echo "<h1>Sample webserver created using terraform on aws instance</h1>">> /var/www/html/index.html
  EOF
  ```
2. Store the provider configuration details in provider.tf.
3. Define all the variables in a variables.tf.
4. Assign the secret variables like AWS access key and secret keys in a separate terraform.tfvars
```terraform
terraform init
terraform plan
terraform apply
```
## Validate the webserver
1. ssh into the public ip of the aws instance with the pem file
2. verify that it outputs the html text
```
chmod 400 terra-udemy.pem
ssh -i "terra-udemy.pem" ec2-user@ec2-3-239-201-90.compute-1.amazonaws.com
sudo su -
cat /var/www/html/index.html
```
3. Also, browse public ip of the ec2 instance and check if the html text is rendered
