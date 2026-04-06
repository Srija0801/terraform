provider "kubernetes" {
config_path = "~/.kube/config"
}

resource "kubernetes_pod" "mongodb_pod" {
metadata {
name = "mongodb-pod"
labels = {
app = "mongodb"
}
}
spec {
container {
image = "mongo"
name = "mongodb"

  port {
    container_port = 27017
  }
}

}
}
