resource "kubernetes_deployment" "app"{
    metadata {
      name = var.name
      namespace = var.namespace
      labels = var.labels
    }
    spec{
        replicas = var.replicas

        selector {
          match_labels = var.labels
        }

        template {
          metadata {
            labels = var.labels
          }

          spec {
            container {
              name = var.name
              image = var.image
              port {
                container_port = var.container_port
              }

              readiness_probe {
                http_get {
                  path = "/"
                  port = var.container_port
                }
                initial_delay_seconds = 5
                period_seconds = 10
              }

              liveness_probe {
                http_get {
                  path = "/"
                  port = var.container_port
                }
                initial_delay_seconds = 10
                period_seconds = 20
              }
            }
          }
        }
    }
}