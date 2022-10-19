locals {
  test_map = {
    cm_data = data.kubernetes_config_map.manual_nginx_html.data
  }
  helm_inputs = {
    autoscaling = !var.migration
    replicas = var.migration ? 0 : 1
    #replicas = var.migration ? 0 : null
  }
}
