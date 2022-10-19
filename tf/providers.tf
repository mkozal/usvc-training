terraform {
  required_providers {
    random = {
      version = ">= 2.1.2"
    }
  }

  required_version = "~> 1.3.0"
}

provider "kubernetes" {
  config_path = "~/.microk8s/config"
  #config_context = "my-context"
}
