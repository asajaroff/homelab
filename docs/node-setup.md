# Node configuration

## Checklist

### TODO New node steps CHECKLIST

```mermaid
flowchart LR
    A[Burn image to SD] --> B[Start the machine]
    B --> C[ssh in, install ansible]
    C --> D[standard-security runbook]
    D --> E[k8s-node-security runbook]
```

- [ ] Burn image to SD storage
- [ ] Start the machine
- Once the node is connected into the network, ssh into it

```sh
sudo apt update --yes
sudo apt install software-properties-common --yes
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install ansible --yes
```

- [ ] Run the `standard-security` runbook. This will disable SSH password and root user
- [ ] Run the `k8s-node-security` runbook. This will give more security

## Operative Systems

### Rocky Linux

Connect through SSH to the machine

```sh
ssh rocky@${RASPBERRY_IP_ADDRESS}
# Default password is `rockylinux`
```

Once you're in, we need to do a few things

#### Install updates and Ansible

```sh
sudo rootfs-expand # Expand filesystem so that is uses the hole available disk
sudo dnf update -y

# Set hostname
export NODE=01
sudo hostnamectl set-hostname "k8s-node-${NODE}.local.lan" --static
sudo hostnamectl set-hostname "K8S Node ${NODE}" --pretty
sudo reboot

# Install ansible
sudo dnf install -y epel-release
sudo dnf install ansible -y
```

#### Allow ${USER} to run sudo and journalctl without password

```shell
EDITOR=vim visudo
# Uncomment following line:
%wheel	ALL=(ALL)	NOPASSWD: ALL
```

#### Disable firewalld

```shell
sudo systemctl disable firewalld --now
sudo systemctl disable nm-cloud-setup.service nm-cloud-setup.timer
sudo reboot
```

#### Create automations user

```sh
ssh-keygen -t ed25519 -f ~/.ssh/nodes.local.lan -C "galera@local.lan_Kubernetes"
```

#### Setup SSH server

```shell
sudo systemctl enable sshd --now
sudo systemctl status sshd.service

# Give correct permissions to authorized users
mkdir ${HOME}/.ssh
chmod 700 ~/.ssh
touch ${HOME}/.ssh/authorized_keys
chmod 600 ${HOME}/authorized_keys
```

#### Install container tools

Run `make init-global-security`

## SSH Keys Creation

```sh
# Create key
ssh-keygen -t ed25519 -f ~/.ssh/nodes.local.lan -C "galera@local.lan_Kubernetes"
ssh-copy-id rocky@${IP_ADDRESS} ~/.ssh.nodes.local.lan.pub
```
