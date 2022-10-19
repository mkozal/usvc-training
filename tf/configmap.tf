resource "kubernetes_config_map" "tf_nginx_html" {
  metadata {
    name      = "cm-test"
    # implicit dependency, makes sure namespace exists before trying to create
    namespace = kubernetes_namespace.this.metadata[0].name
  }

  #data = {
  #  "index.html" = "Terraform-managed config map"
  #}

  data = data.kubernetes_config_map.manual_nginx_html.data


  # worse method, explicit dependency, extra work needed 
  #depends_on = [kubernetes_namespace.this]
}


data "kubernetes_config_map" "manual_nginx_html" {
  metadata {
    name      = "cm-test"
    namespace = "default"
  }

}
