resource "helm_release" "example" {
  name      = "testhelm"
  chart     = "../helmcreatedemo/helloworld"
  namespace = kubernetes_namespace.this.metadata[0].name

  #set {
  #  name = "autoscaling.enabled"
  #  value = true
  #}
  #set {
  #  name = "autoscaling.maxReplicas"
  #  value = 5
  #}
  
  # create set block only if var.migration is set to true. Otherwise replicas are null -> see locals.tf
  dynamic "set" {
    for_each = var.migration ? ["this"] : []
  
    content {
      name = "replicaCount"
      value = local.helm_inputs.replicas
    }
  }


  #values = [
  #  "${file("values.yaml")}"
  #]

  # in-line is beautiful for a small number of args and/or substitions
  values = [ <<-EOT
                autoscaling: 
                  enabled: ${local.helm_inputs.autoscaling}
                  minReplicas: 1 
                  maxReplicas: 10 
                  targetCPUUtilizationPercentage: 80
  EOT
  ]
}
