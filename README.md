This is a Terraform module that builds upon the templates created in [this repo](https://github.com/khaosx/ubuntu-packer-template). When configured and run, multiple servers will be created that will be configured via `ansible` to create all the systems I use in my home lab. This repo bagan as an exercise in teaching myself some shiny new DevOps tools, but is now my production config management system.

## General Info
Please read the notes in [this repo](https://github.com/khaosx/ubuntu-packer-template) for information on the templates used to create thses systems. This repo is unlikely to be functional for anyone, as it is specific to my environment. However, it works, and can therefore be instructional to people attempting a similar build.

| VM Name | Purpose | CPU | RAM | Disk Size | Data Volume | Template Used | 
| :--- | :---: | :---: | :---: | :---: | :---: | :---: |
| titanium | ansible control, molecule, docker | 4 | 8192 | 73728 |  36864 | Ubuntu_18.04_Template_Control |
| chromium | prometheus, grafana | 4 | 8192 | 73728 |  36864 | Ubuntu_18.04_Template_Large |
| copper | plex | 4 | 8192 | 73728 |  36864 | Ubuntu_18.04_Template_Large |
| palladium | DB Server | 4 | 8192 | 73728 |  36864 | Ubuntu_18.04_Template_Large |
| iridium | DNS / DHCP| 1 | 2048 | 28672 |  10240 | Ubuntu_18.04_Template_Small |
| silver | Pi-hole | 1 | 2048 | 28672 |  10240 | Ubuntu_18.04_Template_Small |
| mercury | Docker host #1 | 4 | 8192 | 73728 |  36864 | Ubuntu_18.04_Template_Large |

## Usage

1. Install [HashiCorp Terraform](https://www.terraform.io/)
2. `git clone https://github.com/khaosx/terraform-khaosx-infrastructure.git`
3. Modify the secrets file (secrets.auto.tfvars)
4. From the working directory, run `terraform init`
5. To verify the actions that are about to happen, run `terraform plan`
6. Build all VM's with `terraform apply`
