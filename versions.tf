terraform {
  required_version = ">= 1.5.0"

  required_providers {
    multipass = {
      source  = "todoroff/multipass"
      version = "~> 2.0"
    }
  }
}