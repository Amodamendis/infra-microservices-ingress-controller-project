variable "vpc_id" {
  type = string
}

variable "ingress_ports" {
  type = list(object({
    from        = number
    to          = number
    description = string
  }))
  default = [
    { from = 22, to = 22, description = "SSH" },
    { from = 25, to = 25, description = "SMTP" },
    { from = 80, to = 80, description = "HTTP" },
    { from = 443, to = 443, description = "HTTPS" },
    { from = 465, to = 465, description = "SMTPS" },
    { from = 6443, to = 6443, description = "Kubernetes API" },
    { from = 3000, to = 10000, description = "Custom TCP Apps (Node, Grafana, Jenkins)" },
    { from = 30000, to = 32767, description = "Kubernetes NodePort" }
  ]
}