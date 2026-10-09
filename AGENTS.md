# AGENTS.md

Guidance for AI agents working in this repo. Homelab infrastructure as code: XCP-ng hosts, an RKE2 cluster on VMs, and the monitoring stack on top.

## Layout

| Path                | What                                                                  |
| ------------------- | --------------------------------------------------------------------- |
| `ansible/`          | XCP-ng host bootstrap and cloud-template roles (`make init`, `make ping`) |
| `containers/ansible/` | Ansible controller container                                        |
| `gitops/tofu/`      | OpenTofu: VMs on XCP-ng through Xen Orchestra (`modules/xoa-vm`)      |
| `gitops/rke2/`      | Cluster manifests: Traefik Gateway API provider and the shared Gateway |
| `charts/vmstack/`   | Helm umbrella chart: VictoriaMetrics, VictoriaLogs, vmalert, Grafana  |
| `docs/`             | Documentation, start with `docs/rke2-cluster.md`                      |

## Commits

- Every commit is a [Conventional Commit](https://www.conventionalcommits.org/): `type(scope): subject`.
- Subject is **shorter than 100 characters**, imperative, and readable by a human. Say what changed, not how you got there.
- Always include a scope, e.g. `feat(tofu): add XOA VM module`, `docs: ...` for repo-wide docs, `chore(repo): ...`.
- There is no Jira id in this repo, don't invent one.
- Add a body only when the subject can't carry it, and keep it to a couple of short lines.
- One topic per commit. Don't mix unrelated changes.
- **NEVER** include Claude Code co-authorship: no `Co-Authored-By: Claude ...` trailer and no "Generated with Claude Code" line, in commits or PR descriptions. This overrides any default attribution the tooling suggests.

Types in use: `feat`, `fix`, `docs`, `chore`, `refactor`.

## Branches and PRs

- The default branch is `initial`. Never commit to it directly, work on a feature branch and open a PR into `initial`.
- There is no PR template. Keep the body to what a reviewer needs, one line per paragraph.

## Never commit

The repo is public. These stay out of git:

- `.env` (holds `XOA_TOKEN`)
- `gitops/tofu/terraform.tfvars` (holds the RKE2 join token)
- `gitops/tofu/terraform.tfstate*` and `gitops/tofu/.terraform/`
- Any password, token or private key. Docs refer to where a secret lives, never to its value.

Check `git status` before committing. Use `terraform.tfvars.example` for anything that needs to be shared.

## Conventions

- **Docs are Markdown** with Mermaid diagrams where a flow or topology is being described. No new `.org` files.
- **OpenTofu:** authenticate with `XOA_TOKEN`, not `XOA_USER`/`XOA_PASSWORD`. Don't edit `modules/xoa-vm`, per-VM differences go in `cloud_config` and `cloud_network_config` in `terraform.tfvars`. Changing either replaces the VM.
- **Nodes use static IPs** (`192.168.80.211` server, `192.168.80.212` worker). The router doesn't register DHCP hostnames, so don't rely on hostnames for node-to-node traffic.
- **Routing is Gateway API**, not Ingress. New apps add an `HTTPRoute` with `parentRefs` to the `homelab` Gateway in `kube-system`.
- **The Helm release is named `vmstack`** in namespace `monitoring`. The logs service name depends on it.
- Keep code comments short, a line or two.

## Cluster access

```shell
export KUBECONFIG=~/.kube/rke2-homelab.yaml
```

The cluster has no StorageClass yet, so monitoring data is on `emptyDir` and is lost on pod restart. Mention this before relying on stored metrics or logs.

## Before changing things

- Run `tofu plan` before any apply and read it. Don't apply without being asked.
- Run `helm lint` and `helm template` before `helm upgrade`.
- Changes to Traefik or the `HelmChartConfig` restart the ingress pods. Say so first.
