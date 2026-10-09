# Traefik Ingress Controller setup

## Steps

1. Make sure the Traefik ingress controller is up and running. For the local network listening at 192.168.100.1/24, we can run:

   ```shell
   kubectl get svc traefik -n kube-system -o jsonpath='{.status.loadBalancer.ingress}'
   ```

   Result:

   ```
   ip":"192.168.100.2   ip":"192.168.100.6   ip":"192.168.100.7
   ```

2. Enable port forwarding to the ports exposed by the Ingress Controller

   ```shell
   kubectl get svc traefik -n kube-system -o jsonpath='{.spec.ports[*].nodePort}'
   ```

   Result:

   ```
   30207 32073
   ```
