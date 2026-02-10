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

resource "kubernetes_service" "LB" {
  for_each = var.namespace
  metadata {
    name = "$(var.name)LB"
    namespace = each.key
  }
  spec {
    type = "LoadBalancer"
    selector = var.labels

    port {
      name = "http"
      port = 80
      target_port = var.container_port
    }
  }
}