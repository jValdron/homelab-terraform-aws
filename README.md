# homelab-terraform-aws
Terraform configuration for AWS resources used within Valdron's homelab.

## Prerequisites
### IRSA
Reference: https://nikogura.com/TalosAWSOIDC.html

Obtain the OpenID config:
```
kubectl get --raw /.well-known/openid-configuration > ./irsa/openid-configuration
kubectl get --raw /openid/v1/jwks > ./irsa/jwks.json
```