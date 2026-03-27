# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Infrastructure as Code for a mixed-architecture homelab spanning two environments. Combines Ansible provisioning with Kubernetes (K3S) GitOps deployments. Documentation is written in Org-mode (.org).

## Repository Layout

- `src/` — Original Ansible playbooks, roles, and inventory for the K3S/XCP-ng environment (192.168.100.0/24, 192.168.20.0/24)
- `ansible/inventories/` — Newer per-environment inventories (e.g., `amsterdam.yaml` for the AMS environment)
- `gitops/` — Kubernetes Helm values and manifests (Jenkins, Gitea, WordPress via Traefik ingress)
- `containers/` — Dockerfiles and Makefiles for multi-arch container builds (podman + buildx)
- `docs/` — Org-mode documentation and DrawIO architecture diagrams
- `k3s/` — K3S cluster installation guide
- `bin/` — Helper scripts

## Ansible Commands

All Ansible commands run from `src/`:

```bash
# Ping all hosts
make -C src ping

# Run security initialization (hardened SSH, hostname, updates)
make -C src init

# Install software (podman, buildah, basic tools)
make -C src install

# Shutdown all nodes
make -C src shutdown

# Use a different inventory
make -C src ping INVENTORY=../ansible/inventories/amsterdam.yaml

# Run a specific playbook ad-hoc
ansible-playbook src/01-init.yaml -i src/inventory.yaml
```

## Architecture Notes

- **Two environments**: original K3S cluster (src/inventory.yaml) and Amsterdam (ansible/inventories/amsterdam.yaml) with different host groups and users
- **Mixed architectures**: ARM64 (Raspberry Pi) and AMD64 servers — container builds use `podman buildx` for multi-platform images
- **OS mix**: Rocky Linux (DNF), Debian/Raspbian — playbooks must handle both package managers
- **Ansible cfg** (`src/ansible.cfg`): contains hardcoded paths from a previous setup — override with `-i` flag or environment variables rather than relying on defaults
- **Privilege escalation**: all playbooks use `become: true` with sudo; SSH key auth only (no password login)
- **Playbook numbering**: `01-init.yaml` runs first (security hardening), `02-software.yaml` runs second (package installation)
- **Internal domains**: `*.molest.ar` (subdomains: `int.molest.ar`, `ams.molest.ar`)
- **Ingress**: Traefik load balancer for K3S services
