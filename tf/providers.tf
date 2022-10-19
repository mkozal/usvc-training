terraform {
  required_providers {
    random = {
      version = ">= 2.1.2"
    }
    kubectl = {
      source = "gavinbunney/kubectl"
      version = "1.14.0"
    }
  }

  required_version = "~> 1.3.0"
}

provider "kubernetes" {
  config_path = "~/.microk8s/config"
  #config_context = "my-context"
}
provider "helm" {
  kubernetes {
    config_path = "~/.microk8s/config"
    #config_context = "my-context"
  }
  experiments {
    # for previewing specific resource changes
    manifest = false
  }
}
