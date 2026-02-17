DOCKER_BIN		?= podman
DOCKER_MOUNT 		:= $(PWD):/home/ansible-user/workdir
DOKCER_ANSIBLE_BIN 	:=  podman run -v $(DOCKER_MOUNT) -v ${HOME}/.ssh:/home/ansible-user/.ssh localhost/asajaroff/ansible-bin:0.0.1
# TODO Make ansible properly work in a container error=(provided hosts list is empty, only localhost is available. Note that the implicit localhost does not match 'all')
# ANSIBLE_BIN = podman run -v $(DOCKER_MOUNT) -v ${HOME}/.ssh:/home/ansible-user/.ssh localhost/asajaroff/ansible-bin:0.0.1
ANSIBLE_BIN 		:= ansible
ANSIBLE_PLAYBOOK_BIN 	:= ansible-playbook
INVENTORY 		?= inventory.yaml

.DEFAULT_GOAL: help
.PHONY: all

help:
	@awk 'BEGIN {FS = ":.*##"; printf "Usage: make \033[36m<target>\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

init: ## Setup security features
	$(ANSIBLE_PLAYBOOK_BIN) 01-init.yaml \
		-i inventory.yaml

install: ## Setup boxes from scratch
	$(ANSIBLE_PLAYBOOK_BIN) 02-software.yaml \
		-i inventory.yaml

init-containers: ## Provide Containers capabilities

ping: ## Ping all hosts on the inventory file
	$(ANSIBLE_BIN) all \
		-i $(INVENTORY) \
		-m ping

shutdown: ## Setup boxes from scratch
	$(ANSIBLE_PLAYBOOK_BIN) shutdown.yaml \
		-i inventory.yaml
