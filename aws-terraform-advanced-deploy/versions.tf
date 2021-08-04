terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 3.27.0"
        }
        random = {
            source  = "hashicorp/random"
            version = "3.1.0"
        }
    }

    required_version = "~> 1.0"
}