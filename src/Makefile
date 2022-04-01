
DOCKER_MOUNT = $(PWD):/home/ansible-user/workdir
# ANSIBLE_BIN = podman run -v $(DOCKER_MOUNT) -v ${HOME}/.ssh:/home/ansible-user/.ssh localhost/asajaroff/ansible-bin:0.0.1
ANSIBLE_BIN = ansible

run:
	$(ANSIBLE_BIN) all -m ping -i inventory.yaml

ping:
	$(ANSIBLE_BIN) all -m ping -i inventory.yaml

list:
	$(ANSIBLE_BIN) all --list-hosts -i inventory.yaml
