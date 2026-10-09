# k3s Node configuration

## Checklist

### Install and configure node according to [general security](GeneralSecurity.md) guidelines.

### Fetch the cluster token node from the Master instance:

```shell
export K3S_TOKEN="$(ssh -i ~/.ssh/nodes.k8s.local rocky@192.168.100.2 -- sudo cat /var/lib/rancher/k3s/server/node-token)"
```

### Launch the node

```shell
export NODE_IP=192.168.100.6
export K3S_MASTER_IP=192.168.100.2
ssh -i ~/.ssh/nodes.k8s.local rocky@${NODE_IP} -- "curl -sfL https://get.k3s.io | K3S_URL=https://${K3S_MASTER_IP}:6443 K3S_TOKEN=${K3S_TOKEN} sh -"
```

### Enable cgroup memory

Add the following bit at the end of the `/boot/cmdline.txt` file.

```shell
cgroup_memory=1 cgroup_enable=memory
```

## User managment

-
