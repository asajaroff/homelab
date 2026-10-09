# Ansible container

Ansible plus the tools the `cloud-template` role needs on the controller.

| Tool                 | Version                                   |
| -------------------- | ----------------------------------------- |
| ansible-core         | 2.21.4 (pinned via `ANSIBLE_CORE_VERSION`) |
| ansible.posix        | 2.2.2 (`requirements.yml`)                |
| qemu-img, libguestfs | from Debian trixie                        |

## Build

```sh
make build
make versions
```

## Usage

Run from the repo's `ansible/` directory. `--device /dev/kvm` makes `virt-customize` fast; drop it if the host has none.

```sh
alias ansible-box='docker run --rm -it --device /dev/kvm \
    -v "$PWD":/work \
    -v ~/.ssh:/home/ansible/.ssh:ro \
    -v ~/.cache/xcp-template:/home/ansible/.cache/xcp-template \
    docker.io/asajaroff/ansible-bin:0.1.0'

ansible-box ansible-playbook template.yaml
```

The container user is uid 1000, so the mounted keys must be readable by it.
