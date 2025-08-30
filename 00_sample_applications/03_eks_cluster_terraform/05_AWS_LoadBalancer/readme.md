# LoadBalancer Controller (TLS)



- To secure application with TLS, you need to deploy cert-manager with automatically obtain and renews certificate from Let's Encrypt (Cloudflare, Venafi, Hashicorp Vault)
- To store the certificate and private key inside kubernetes and mounted them to the NGINX pod. It can terminate TLS and route traffic to your application.