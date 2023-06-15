# About 
This repo will contain a guide and the nessessary terraform configuration to setup and configure an EC2 instance of an Amazon Linux 2023 server that will automatically create a service to contain the Minecraft Java server. The service will maintain the minecraft server at all times, allowing it to automatically start upon reboots of the Linux server/EC2 instance.

# Requirements:
To use, you'll need an [AWS account](https://aws.amazon.com/). You'll also need to install the [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) and the [Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli). Follow the linked guides to do so. 

## Pre-configuration
Before you're able to run the preconfigured terraform EC2 instance, you'll need to configure your AWS credentials so your terraform installation can access your AWS account. 
You'll need to edit the AWS CLI credentials file. This file will be located at `~/.aws/credentials` on Linux or macOS, or at ``C:\Users\`USERNAME`\.aws\credentials`` on Windows. 
More information on adding your credentials to this file can be found [here](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html).

## Setup
### Diagram of pipeline.
    Terraform -> AWS EC2 Config
			  -> SSH -> Bash Script -> Minecraft Installation
						-> Minecraft Service setup

### Steps to run
- Be sure to check the requirements and pre-configuration sections of this guide  before proceeding to these steps.
1. Download/Clone repo to desired working directory.
2. Open a command line and browse to the directory you copied this repo's files to.
3. Enter the command `terraform init` to initialize the current directory with Terraform.
4. Enter the command `terraform apply` to apply the Terraform configuration, and begin creating the instance in AWS.
	- If asked to confirm changes, enter `yes`
5. Wait for this command to finish. It will take some time.
	- Once complete, you should see output with the public IP. This will be the IP address needed to connect to the minecraft server.

### To connect a Minecraft client to the sever
- Use the public IP that was output from terraform. If forgotten, this can be found by running the following command `terraform output`
- This guide has been set up using the latest version of the Minecraft Java releae. Be sure to use the Minecraft Java client to connect.

