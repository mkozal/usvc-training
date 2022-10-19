locals {
  test_map = {
    cm_data = data.kubernetes_config_map.manual_nginx_html.data
  }
}
