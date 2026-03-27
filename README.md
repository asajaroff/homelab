# Homelab

Infrastructure as code for my homelab. Ansible playbooks for node provisioning, Kubernetes (K3S) manifests for app deployments, and container builds for mixed ARM64/AMD64 architectures.

## Structure

```
src/                  Ansible playbooks and inventory (original K3S/XCP-ng environment)
ansible/inventories/  Per-environment inventories (e.g. amsterdam.yaml)
gitops/               Helm values and K8S manifests (Jenkins, Gitea, WordPress)
containers/           Dockerfiles and Makefiles for multi-arch builds (podman)
docs/                 Org-mode documentation and diagrams
k3s/                  K3S cluster setup notes
bin/                  Helper scripts
```

## Prerequisites

- Ansible
- SSH key access to target nodes (key-based auth only, no passwords)
- podman (for container builds)

## Ansible

Playbooks live in `src/` and run in order:

1. `01-init.yaml` — Security hardening: SSH config, hostname, system updates, disable firewalld
2. `02-software.yaml` — Install packages: curl, jq, podman, buildah, etc.
3. `shutdown.yaml` — Power off all nodes

Run from the repo root:

```bash
make -C src help       # List all targets
make -C src ping       # Test connectivity
make -C src init       # Run security setup
make -C src install    # Install software
make -C src shutdown   # Shut down nodes
```

To use a different inventory:

```bash
make -C src ping INVENTORY=../ansible/inventories/amsterdam.yaml
```

### Environments

| Environment | Inventory | Networks |
|---|---|---|
| K3S cluster | `src/inventory.yaml` | 192.168.100.0/24, 192.168.20.0/24 |
| Amsterdam | `ansible/inventories/amsterdam.yaml` | 192.168.60.0/24 |
| Ituzaingo | `ansible/inventories/ituzaingo.yaml` | 192.168.80.0/24 |

## Containers

Each container has its own directory under `containers/` with a Dockerfile and Makefile.

```bash
make -C containers/ansible build   # Build with podman buildx
make -C containers/ansible push    # Push to registry
```

## GitOps

Helm values and manifests for K3S services in `gitops/`:

- `namespaces/jenkins/` — Jenkins with Kubernetes plugin
- `namespaces/utils/gitea.yaml` — Gitea with PostgreSQL
- `websites/` — WordPress (Bitnami chart)

All services use Traefik as ingress controller under the `*.molest.ar` internal domain.

## Docs

Documentation is in `docs/` as Org-mode files covering networking, security, node setup, virtualization, Traefik, and architecture decisions.
