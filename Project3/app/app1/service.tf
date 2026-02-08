resource "kubernetes_service" "clusterip"{
    metadata {
      name = "$(var.name)-clusterip"
      namespace = var.namespace
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