variable "enable_k8s" {
  default = true
}

provider "kubernetes" {
  config_path = "~/.kube/config"

  # 👇 THIS IS THE FIX
  alias = "local"
}

# Dummy provider for CI (prevents loading error)
provider "kubernetes" {
  alias = "ci"
}
