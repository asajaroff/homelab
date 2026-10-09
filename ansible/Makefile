ANSIBLE_BIN 		:= ansible
ANSIBLE_PLAYBOOK_BIN 	:= ansible-playbook
INVENTORY 		?= inventory.yaml

.DEFAULT_GOAL: help
.PHONY: all

help:
	@awk 'BEGIN {FS = ":.*##"; printf "Usage: make \033[36m<target>\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

init: ## Bootstrap adminera user/sudo and apply physical-host baseline
	@echo "New node? First copy the adminera key to root (one-time, prompts for the install-time root password):"
	@echo "  ssh-copy-id -i ~/.ssh/boleadoras.pem.pub root@<host-ip>"
	$(ANSIBLE_PLAYBOOK_BIN) site.yaml \
		-i $(INVENTORY)

ping: ## Ping all hosts on the inventory file
	$(ANSIBLE_BIN) all \
		-i $(INVENTORY) \
		-m ping

template: ## Build the cloud-init VM template on the XCP-ng host
	$(ANSIBLE_PLAYBOOK_BIN) template.yaml \
		-i $(INVENTORY)
