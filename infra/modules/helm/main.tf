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

  set = [ {
    name = "crds.enabled"
    value = "true"
  } ]

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

