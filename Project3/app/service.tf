resource "kubernetes_service" "clusterip"{
  for_each = var.namespace
    metadata {
      name = "$(var.name)-clusterip"
      namespace = each.key
    }

    spec {
      type = "ClusterIP"
      selector = var.labels

      port {
        name = "http"
        port = var.service_port
        target_port = var.container_port
      }
    }
}