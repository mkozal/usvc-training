resource "kubernetes_namespace" "istio" {
  metadata {
    name = "istio-system"

    labels = {
      istio-operator-managed = "Reconcile"
      istio-injection        = "disabled"
    }
  }
}

resource "helm_release" "istio_base" {
#  count = 0
  name         = "istio-base"
  force_update = true
  chart        = "base"
  repository   = "https://istio-release.storage.googleapis.com/charts"
  namespace    = kubernetes_namespace.istio.metadata[0].name
}


resource "kubernetes_manifest" "istio_ingress_virtual_service" {
  count = 0
  manifest = {
    apiVersion = "networking.istio.io/v1alpha3"
    kind       = "VirtualService"
    metadata = {
      name      = "ingress-vs"
      namespace = kubernetes_namespace.istio.metadata[0].name
    }
  }
  depends_on = [ helm_release.istio_base ]
}
resource "kubectl_manifest" "istio_ingress_virtual_service" {
  yaml_body = <<YAML
apiVersion: "networking.istio.io/v1alpha3"
kind: "VirtualService"
metadata:
  name: "ingress-vs"
  namespace: ${kubernetes_namespace.istio.metadata[0].name}
YAML
}
