resource "helm_release" "nginx" {
  name = "nginx-ingress"

  repository = "https://helm.nginx.com/stable"
  chart      = "nginx-ingress"

  create_namespace = true
  namespace        = "nginx-ingress"
}

resource "helm_release" "cert_manager" {
  name = "cert-manager"

  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"

  create_namespace = true
  namespace        = "cert-manager"

  atomic  = true
  wait    = true
  timeout = 600
  cleanup_on_fail = true


  depends_on = [helm_release.nginx]

  values = [file("${path.module}/../../helm-values/cert-manager.yaml")]

}

resource "helm_release" "external_dns" {
  name = "external-dns"

  repository = "https://kubernetes-sigs.github.io/external-dns/"
  chart      = "external-dns"

  create_namespace = true
  namespace        = "external-dns"


  values = [file("${path.module}/../../helm-values/external-dns.yaml")]

}

resource "helm_release" "argo_cd" {
  name = "argo-cd"

  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "7.7.11"

  create_namespace = true
  namespace        = "argo-cd"

  values = [file("${path.module}/../../helm-values/argo-cd.yaml")]

  depends_on = [helm_release.cert_manager]

}

