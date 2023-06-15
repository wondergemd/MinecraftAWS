# About 
This repo will contain a guide and the nessessary terraform configuration to setup and configure an EC2 instance of an Amazon Linux 2023 server that will automatically create a service to contain the Minecraft Java server. The service will maintain the minecraft server at all times, allowing it to automatically start upon reboots of the Linux server/EC2 instance.
## Requirements:
To use, you'll need an [AWS account](https://aws.amazon.com/). You'll also need to install the [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) and the [Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli). Follow the linked guides to do so. 

## Pre-configuration
Before you're able to run the preconfigured terraform EC2 instance, you'll need to configure your AWS credentials so your terraform installation can access your AWS account. 

- **Should the user set environment variables or configure anything?**
- **Diagram of the major steps in the pipeline.** 
- **List of commands to run, with explanations.**
- **How to connect to the Minecraft server once it's running?**
