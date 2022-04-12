#
# Janky front-end for EC2
# 
#
#==============================

# One-time configuration
# You will need to specify these the first time you use this file
# but typically can leave them the same for all further use

#
# Set your region here.  Other definitions depend upon this.
#

# The preferred region is us-west-2 (Oregon)
REGION=us-west-2

# This alternate regions is available if Canadian data residency is important.
# NOTE: We have not defined every AMI or instance for this region.
# You will have to add some more if you turn set this region.

#REGION=ca-central-1

#
# You need to specify a security group id. A default will have been
# created for you after you use the Web console to launch an EC2 instance.
#
# For your security group, either:
#  1. https://us-west-2.console.aws.amazon.com/ec2/v2/home?region=us-west-2#SecurityGroups:
#     https://ca-central-1.console.aws.amazon.com/ec2/v2/home?region=ca-central-1#SecurityGroups:
#  2. aws ec2 describe-security-groups --output json | jq '.SecurityGroups[].GroupId'

# Security group ID
SGI_WFH=

# Optional for displaying a security group rule via the "sgr" target
# ID for security group rule ID to be displayed in detail
SGRI_WFH=

#
# Specify the name of your key-pair; 
#  1. https://us-west-2.console.aws.amazon.com/ec2/v2/home?region=us-west-2#KeyPairs:
#     https://ca-central-1.console.aws.amazon.com/ec2/v2/home?region=ca-central-1#KeyPairs:
#  2. aws ec2 describe-key-pairs
#
# Name of EC2 key
KEY=
# Path to file, including filename
LKEY=

# End of configuration section

# Check that required variables have been defined

ifeq ($(SGI_WFH),)
  $(error Variable SGI_WFH has not been defined)
else ifeq ($(KEY),)
  $(error Variable KEY has not been defined)
else ifeq ($(LKEY),)
  $(error Variable LKEY has not been defined)
else
  # We're good to go!
  # SGRI_WFH is optional so we don't require it
endif

#==============================
#
# see here for latest instance types: 
#   https://us-west-2.console.aws.amazon.com/ec2/v2/home?region=us-west-2#InstanceTypes:
#   https://ca-central-1.console.aws.amazon.com/ec2/v2/home?region=ca-central-1#InstanceTypes:
#
# Prices also vary somewhat by region (though general proportions are the same)
#
#==============================
# x86 instances

# Note: For EC2, "Free Tier" is only for first 12 months
# (https://aws.amazon.com/ec2/pricing/?loc=ft#Free_tier)
FREETIER=t2.micro

T2C1M1=t2.micro
T2C1M2=t2.small
T2C2M4=t2.medium

# USD 0.0928/hr
T2C2M8=t2.large

T2C4M16=t2.xlarge
T2C8M32=t2.2xlarge

# USD 0.10/hr
M4C2M8=m4.large
M4C16M64=m4.4xlarge

#==============================
# ARM (AWS brands as "Graviton") instances
# Graviton instances identified by "g" suffix of primary category: "t4g"

# No ARM instances in Free Tier
# This is cheapest as of Jan 2022
# USD 0.0042 / hr in us-west-2
# USD 0.0046 / hr in ca-central-1
FREETIER_ARM=t4g.nano

# USD 0.077/hr in us-west-2
# Not available (Jan 2022) in ca-central-1
M6C2M8_ARM=m6g.large

#==============================
# GPU instances
# You will need an AMI that includes GPU software, such as
# AMI_AMAZON_LINUX_GPU

#==============================
# x86-based GPU instances
# https://aws.amazon.com/ec2/instance-types/g4/

# Use AMD GPUs for graphics applications 

# g4ad.2xlarge = 8 vCPUs; 4 Cores; x86_64 2d gen. AMD EPYC processors; 32GB; AMD Radeon Pro V520 GPUs; up to 10 Gb networking
# USD $0.54117/hr in us-west-2
# USD $0.60421/hr in ca-central-1
GPU_GRAPHICS_2X=g4ad.2xlarge

# Use NVIDIA GPUs for Machine Learning (ML) applications
# https://aws.amazon.com/ec2/instance-types/g4/

# g4dn.xlarge = 4 vCPUs; 2 Cores; x86_64 Intel Cascade Lake CPU; 16GB; Nvidia T4 w/16GB; up to 25 Gb networking
# USD 0.526/hr in us-west-2
# USD 0.584/hr in ca-central-1
GPU_ML_X=g4dn.xlarge

# g4dn.2xlarge = 8 vCPUs; 4 Cores; x86_64 Intel Cascade Lake CPU; 32GB; Nvidia T4 w/16GB; up to 25 Gb networking
# USD 0.752/hr in us-west-2
# USD 0.835/hr in ca-central-1
GPU_ML_2X=g4dn.2xlarge

# g4dn.4xlarge = 16 vCPUs; 8 Cores; x86_64 Intel Cascade Lake CPU; 64GB; Nvidia T4 w/16GB; up to 25 Gb networking
# USD 1.204/hr in us-west-2
# USD 1.337/hr in ca-central-1
GPU_ML_4X=g4dn.4xlarge

# g4dn.8xlarge = 32 vCPUs; 16 Cores; x86_64 Intel Cascade Lake CPU; 128GB; Nvidia T4 w ; up to 50 Gb networking
# USD 2.416/hr in us-west-2
GPU_ML_8X=g4dn.8xlarge

#==============================
# ARM-based GPU instances
# https://aws.amazon.com/ec2/instance-types/g5g/
# As of Jan 2022, no ARM-based GPU instances in ca-central-1

# g5g.2xlarge = 8 vCPUs; Graviton 2; 16 GiB; Nvidia T4G Tensor Core w/16GB; Up to 10 Gb networking
# USD 0.556/hr in us-west-2
GPU_ML_2X_ARM=g5g.2xlarge

# g5g.4xlarge = 16 vCPUs; Graviton 2; 32 GiB; Nvidia T4G Tensor Core w/16GB; Up to 10 Gb networking
# USD 0.828/hr in us-west-2
GPU_ML_4X_ARM=g5g.4xlarge

# g5g.8xlarge = 32 vCPUs; Graviton 2; 64 GiB; Nvidia T4G Tensor Core w/16GB; Up to 12 Gb networking
# USD 1.372/hr in us-west-2
GPU_ML_8X_ARM=g5g.8xlarge

# g5g.16xlarge = 64 vCPUs; Graviton 2; 128 GiB; 2 Nvidia T4G Tensor Cores, each w/16GB; Up to 25 Gb networking
# USD 2.744/hr in us-west-2
GPU_ML_16X_ARM=g5g.16xlarge

#==============================
# Habana-based special-purpose machine learning processors
# https://aws.amazon.com/ec2/instance-types/dl1/
# dl1.24xlarge = 96 vCPUs; 768 GiB; 8 Gaudi accelerators + custom 2d. gen. Intel Xeon Scalable processors; 400 Gb networking
# USD $13.10904/hr in us-west-2
HABANA_24X=dl1.24xlarge

#==============================
# NB: AMI are region-specific!
# This is why REGION must be defined above

ifeq ($(REGION),us-west-2)

# us-west-2
AMI_UBUNTU20_X86=ami-036d46416a34a611c
AMI_UBUNTU20_ARM=ami-017d56f5127a80893 

# Deep Learning AMI (Amazon Linux 2) Version 55.0
# MXNet-1.8.0 & 1.7.0, TensorFlow-2.4.3, 2.3.4 & 1.15.5, PyTorch-1.7.1 & 1.8.1, Neuron, & others. NVIDIA CUDA, cuDNN, NCCL, Intel MKL-DNN, Docker, NVIDIA-Docker & EFA support. 
# us-west-2
AMI_AMAZON_LINUX_ML=ami-0a100c9a1c22dd744
# https://aws.amazon.com/releasenotes/deep-learning-ami-graviton-gpu-pytorch-1-10-ubuntu-20-04/
AMI_UBUNTU_ML_ARM=ami-09901fdae1bac6fe0

# Deep Learning Base AMI (Amazon Linux 2) Version 47.0
# Built with NVIDIA CUDA, cuDNN, NCCL, GPU Drivers, Intel MKL-DNN, Docker, NVIDIA-Docker and EFA support.
# Does NOT include Python libraries
# us-west-2
AMI_AMAZON_LINUX_GPU_BASE=ami-07b2b9c336eb8f9ed

# Deep Learning AMI for Habana AI processors (Amazon Linux 2) PyTorch SynapseAI
AMI_AMAZON_LINUX_ML_HABANA=ami-0ebd5e733813c3d24

else ifeq ($(REGION),ca-central-1)

# We haven't done as comprehensive a listing for this region
# Add to this as you find images

AMI_UBUNTU20_X86=ami-0aee2d0182c9054ac
AMI_UBUNTU20_ARM=ami-04e842c4cdd82c62e

# Deep Learning Base AMI (Amazon Linux 2) Version 47.0
# Built with NVIDIA CUDA, cuDNN, NCCL, GPU Drivers, Intel MKL-DNN, Docker, NVIDIA-Docker and EFA support. 
# ca-central-1
AMI_AMAZON_LINUX_GPU_BASE=ami-052d016a605f10da4

else

$(error No images (AMIs) defined for region $(REGION))

endif

# the ssh user is dependent on the distro
AMAZON_USER=ec2-user
UBUNTU_USER=ubuntu

#==============================
#
# Package definitions
#

# You may need to extend these to add further packages

# These three variables are linked:
# The image must be appropriate for the instance and the
# ssh user must be the user defined for the image's distribution

# This defines the default to be empty.
# If PKG is specified on the command line, this
# definition is ignored.
PKG=

# To run x86 instances, define these

ifeq ($(PKG),gpu)

# Mid-tier GPU with Python-based AMI
# USD 0.752/hr in us-west-2
INSTANCE=$(GPU_ML_2X)
IMAGE=$(AMI_AMAZON_LINUX_ML)
SSH_USER=$(AMAZON_USER)

else ifeq ($(PKG),gpu_small)

# Cheaper GPU with Python-based AMI
# USD 0.526/hr in us-west-2
INSTANCE=$(GPU_ML_X)
IMAGE=$(AMI_AMAZON_LINUX_ML)
SSH_USER=$(AMAZON_USER)

else ifeq ($(PKG),gpu_big)

# More expensive GPU with Python-based AMI
# USD 1.204/hr in us-west-2
INSTANCE=$(GPU_ML_4X)
IMAGE=$(AMI_AMAZON_LINUX_ML)
SSH_USER=$(AMAZON_USER)

else ifeq ($(PKG),gpu_very_big)

# Even more expensive GPU with Python-based AMI
# USD 2.416/hr in us-west-2
INSTANCE=$(GPU_ML_8X)
IMAGE=$(AMI_AMAZON_LINUX_ML)
SSH_USER=$(AMAZON_USER)

else ifeq ($(PKG),habana)

# EXPENSIVE special-purpose AI processor
# Requires prior authorization from http://aws.amazon.com/contact-us/ec2-request
# to allow an account to request
# USD 13.10904/hr in us-west-2
INSTANCE=$(HABANA_24X)
IMAGE=$(AMI_AMAZON_LINUX_ML_HABANA)
SSH_USER=$(AMAZON_USER)

else ifeq ($(PKG),gpu_no_python)

# Cheaper GPU with simpler AMI lacking Python
# You probably don't want to use this package
INSTANCE=$(GPU_ML_X)
IMAGE=$(AMI_AMAZON_LINUX_GPU)
SSH_USER=$(AMAZON_USER)

else ifeq ($(PKG),)

# DEFAULT package

# Free tier
INSTANCE=$(FREETIER)
IMAGE=$(AMI_UBUNTU20_X86)
SSH_USER=$(UBUNTU_USER)

else

$(error Unknown package name '$(PKG)')

endif

# This defines the default to be empty.
# If ARMPKG is specified on the command line, this
# definition is ignored.
ARMPKG=

# To run ARM instances, define these

ifeq ($(ARMPKG),gpu)

# Mid-tier instance with 1 GPU
# USD 0.828/hr in us-west-2
INSTANCE_ARM=$(GPU_ML_4X_ARM)
IMAGE_ARM=$(AMI_UBUNTU_ML_ARM)
SSH_USER_ARM=$(UBUNTU_USER)

else ifeq ($(ARMPKG),gpu_small)

# Cheaper instance with 1 GPU
# USD 0.556/hr in us-west-2
INSTANCE_ARM=$(GPU_ML_2X_ARM)
IMAGE_ARM=$(AMI_UBUNTU_ML_ARM)
SSH_USER_ARM=$(UBUNTU_USER)

else ifeq ($(ARMPKG),gpu_big)

# More expensive instance with 1 GPU
# USD 1.372/hr in us-west-2
INSTANCE_ARM=$(GPU_ML_8X_ARM)
IMAGE_ARM=$(AMI_UBUNTU_ML_ARM)
SSH_USER_ARM=$(UBUNTU_USER)

else ifeq ($(ARMPKG),gpu_very_big)

# Even more expensive instance with 2 GPUs
# USD 2.744/hr in us-west-2
INSTANCE_ARM=$(GPU_ML_16X_ARM)
IMAGE_ARM=$(AMI_UBUNTU_ML_ARM)
SSH_USER_ARM=$(UBUNTU_USER)

else ifeq ($(ARMPKG),)

# DEFAULT package

# Free tier
INSTANCE_ARM=$(FREETIER_ARM)
IMAGE_ARM=$(AMI_UBUNTU20_ARM)
SSH_USER_ARM=$(UBUNTU_USER)

else

$(error Unknown package name '$(PKG)')

endif

# End package definitions
#==============================

SHUTDOWN_BEH=terminate

# The subdirectory for log files
# The next two statements will be automatically selected by
# the xfer.sh script---do not modify them
# Set to '.' to place logs in current directory
#LOGD=.
# Set to a subdirectory to place logs there. Do not include the trailing '/' in the subdirectory path
LOGD=logs

# this is used to provide a value for the tag mnemonic-name to make instances easier to recognize/recall a la Docker
NAMING_SVC=https://frightanic.com/goodies_content/docker-names.php


.phony=sgr sg up ssh sshdns up-arm ssh-arm keyfile

# Display the details of a single security group rule
sgr:
	aws --region $(REGION) --output json ec2 describe-security-group-rules --security-group-rule-ids $(SGRI_WFH)

# Display the current security group
sg:
	aws --region $(REGION) --output json ec2 describe-security-groups --group-id $(SGI_WFH)

# Return the path to the keyfile
# Called by bash alias functions that need to ssh
keyfile:
	@echo $(LKEY)

#
# SSH into an instance identified by its external DNS name
# Typically called by an alias that looked up the DNS name using a tag, such as 'happy_newton'
#
sshdns:
	ssh -i $(LKEY) $(SSH_USER)@$(EC2_DNS)

#
# Start an x86 instance
# this saves the public IP of the instance into x86-ip.log which is used hand-off to the ssh target for seamless login
# x86-id.log contains the instance id
# 
up:
	aws --region $(REGION) --output json ec2 run-instances \
		--instance-type $(INSTANCE) \
		--image-id $(IMAGE) \
		--instance-initiated-shutdown-behavior $(SHUTDOWN_BEH) \
		--security-group-ids $(SGI_WFH) \
		--key-name $(KEY) \
		--tag-specifications 'ResourceType=instance,Tags=[{Key=mnemonic-name,Value='`curl --silent $(NAMING_SVC)`'}]' \
			| tee $(LOGD)/up.log | jq -r '.Instances[].InstanceId' > $(LOGD)/x86-id.log
	aws ec2 wait instance-exists --instance-id `cat $(LOGD)/x86-id.log`
	aws --region $(REGION) --output json ec2 describe-instances --instance-id `cat $(LOGD)/x86-id.log` | tee $(LOGD)/up.log | jq -r '.Reservations[].Instances[].PublicIpAddress' > $(LOGD)/x86-ip.log
	jq -r '.Reservations[].Instances[]| .PublicIpAddress + " " + .Tags[0].Value' $(LOGD)/up.log

ssh:
	ssh -i $(LKEY) $(SSH_USER)@`cat $(LOGD)/x86-ip.log`

#
# Start an ARM (Graviton) instance
#
up-arm:
	aws --region $(REGION) --output json ec2 run-instances \
		--instance-type $(INSTANCE_ARM) \
		--image-id $(IMAGE_ARM) \
		--instance-initiated-shutdown-behavior $(SHUTDOWN_BEH) \
		--security-group-ids $(SGI_WFH) \
		--key-name $(KEY) \
		--tag-specifications 'ResourceType=instance,Tags=[{Key=mnemonic-name,Value='`curl --silent $(NAMING_SVC)`'}]' \
			| tee $(LOGD)/up-arm.log | jq -r '.Instances[].InstanceId' >$(LOGD)/arm-id.log
	aws ec2 wait instance-exists --instance-id `cat $(LOGD)/arm-id.log`
	aws --region $(REGION) --output json ec2 describe-instances --instance-id `cat $(LOGD)/arm-id.log` | tee $(LOGD)/up-arm.log | jq -r '.Reservations[].Instances[].PublicIpAddress' > $(LOGD)/arm-ip.log
	jq -r '.Reservations[].Instances[]| .PublicIpAddress + " " + .Tags[0].Value' $(LOGD)/up-arm.log
	
ssh-arm:
	ssh -i $(LKEY) $(SSH_USER_ARM)@`cat $(LOGD)/arm-ip.log`

