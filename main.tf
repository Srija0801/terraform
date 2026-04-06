# Variable to enable/disable Kubernetes resources
variable "enable_k8s" {
  default = true
}

# Kubernetes Deployment for MongoDB
resource "kubernetes_deployment_v1" "mongodb" {
  count = var.enable_k8s ? 1 : 0

  metadata {
    name = "mongodb-deployment"
    labels = {
      app = "mongodb"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "mongodb"
      }
    }

    template {
      metadata {
        labels = {
          app = "mongodb"
        }
      }

      spec {
        container {
          name  = "mongodb"
          image = "mongo:latest"

          port {
            container_port = 27017
          }
        }
      }
    }
  }
}

# Kubernetes Service for MongoDB
resource "kubernetes_service_v1" "mongodb_service" {
  count = var.enable_k8s ? 1 : 0

  metadata {
    name = "mongodb-service"
  }

  spec {
    selector = {
      app = "mongodb"
    }

    port {
      port        = 27017
      target_port = 27017
    }

    type = "NodePort"
  }
}
