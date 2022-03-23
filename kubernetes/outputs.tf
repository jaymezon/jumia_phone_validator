output "load_balancer_hostname" {
  value = kubernetes_ingress.jumia.status.0.load_balancer.0.ingress.0.hostname
}