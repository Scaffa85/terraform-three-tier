# Deployer Key

variable "deployer-key-name" {
  default = "deployer-key"
}

variable "deployer-key" {
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC1C5UNrYaMlh5Rqab8WnHVr2L8QHjidneA4drqGYYz2CpxZmZJmrTA2xVxuI3p2Tt9KFf6o9+auiNc8Mpegft5ZgH9X2CkBzi8HRgHkiOQZlOoQDRabu9L7YpBYX2DQM4hvzZ3f7/a32orC6QAkThAxjKFt+VNAnIFeImbXRTx8HpxTuhSU20NIs1uT9yEwhidqFDtO8Rr5w8aJONs6QgxjdhbXdBqc1bf78N+V7plQZWLGxaLPLT3oyOdhcA3fQAN4lXrK3rHdWDIItFkJyWlsGoOCYWnic6U7pAghbBANJu91PYRfYojYKEqVPKG78lMzv2vvkD6RIVcbi2DRaVh"
}

# Global Variables / Mappings
variable "environment" {
  // Set to "production" to use actual instance sizes
  default = "preview" // Set to "preview" to use t2.micro's and save some money.
}

variable "region" {
  default = "eu-west-2"
}

variable "cidr_range" {
  default = "10.0.0.0/8"
}

variable "deletion_protection_on" {
  default = {
    preview    = "false"
    production = "true"
  }
}

variable "rhel_amis" {
  description = "Mapping of RHEL 7.5 AMIs."

  default = {
    eu-west-1 = "ami-664b0a11"
    eu-west-2 = "ami-7c1bfd1b"
  }
}

# Bastion Host Variables

variable "bastion_instance_size" {
  default = {
    preview    = "t2.micro"
    production = "t2.medium"
  }
}

# Metadata Tier Variables
variable "metadata_tier_instance_size" {
  default = {
    preview    = "t2.micro"
    production = "m5.2xlarge"
  }
}

variable "metadata_tier_instance_count" {
  default = "1"
}

# Mid Tier Variables
variable "mid_tier_instance_size" {
  default = {
    preview    = "t2.micro"
    production = "r5.2xlarge"
  }
}

variable "mid_tier_instance_count" {
  default = "2"
}

# Compute Tier Variables
variable "compute_tier_instance_size" {
  default = {
    preview    = "t2.micro"
    production = "i3.8xlarge"
  }
}

variable "compute_tier_instance_count" {
  default = "3"
}

# VIYA Services 

variable "viya_services_instance_size" {
  default = {
    preview    = "t2.micro"
    production = "x1e.xlarge"
  }
}

variable "viya_services_instance_count" {
  default = "1"
}

# VIYA CAS Mid Tier Variables (Prim/Sec)

variable "cas_mid_tier_instance_size" {
  default = {
    preview    = "t2.micro"
    production = "r5.2xlarge"
  }
}

variable "cas_mid_tier_instance_count" {
  default = "2"
}

# VIYA CAS Worker Tier Variables
variable "cas_worker_instance_size" {
  default = {
    preview    = "t2.micro"
    production = "i3.8xlarge"
  }
}

variable "cas_worker_instance_count" {
  default = "3"
}

variable "cas_worker_lb_port" {
  default = "8001"
}

# HPAE Head

variable "hpae_head_instance_size" {
  default = {
    preview    = "t2.micro"
    production = "i3.8xlarge"
  }
}

variable "hpae_head_instance_count" {
  default = "1"
}

# HPAE Workers

variable "hpae_worker_tier_instance_size" {
  default = {
    preview    = "t2.micro"
    production = "i3.8xlarge"
  }
}

variable "hpae_worker_tier_instance_count" {
  default = "3"
}
