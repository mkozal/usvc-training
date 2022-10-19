terraform {
  backend "kubernetes" {
    secret_suffix    = "tfstate"
    config_path      = "~/.microk8s/config"
    namespace        = "kube-system"
  }
}
