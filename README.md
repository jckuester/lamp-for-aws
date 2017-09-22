# Demo: A LAMP Stack for AWS

<p>
 <img src="img/lamp.png" alt="LAMP Stack architecture">   
 <em>Figure 1: LAMP Stack architecture</em>
</p>

## Requirements

* AWS Account (free tier)
* aws-cli 1.10.33
* Packer v0.12.3
* Terraform v0.10.0
* librarian-chef 0.0.4

## Getting started

Create an AWS profile for your personal account:

1. `aws configure --profile personal set aws_access_key_id YOUR_AWS_ACCESS_KEY_ID`
2. `aws configure --profile personal set aws_secret_access_key YOUR_AWS_SECRET_ACCESS_KEY`
3. `aws --profile personal configure set region us-west-2`

## Packer

```
cd packer/
librarian-chef install
./build_amis.sh 1
```

## Terraform

Create LAMP Stack:

```
cd terraform/
./terraform.sh personal init
./terraform.sh personal plan
./terraform.sh personal apply
```

Tear down LAMP Stack:

```
cd terraform/
./terraform.sh personal destroy
```
