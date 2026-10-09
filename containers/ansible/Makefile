# Standard vars
NAME		:= ansible-bin
VERSION		:= 0.1.0
REGISTRY	:= docker.io/asajaroff/$(NAME)

# Docker Vars
DOCKER_BIN 	?= docker
DOCKER_TAG 	:= $(REGISTRY):${VERSION}

build:
	$(DOCKER_BIN) build . \
		-t $(DOCKER_TAG) \
		--platform=linux/amd64

push:
	$(DOCKER_BIN) push $(DOCKER_TAG)

versions: ## Print the tool versions baked into the image
	$(DOCKER_BIN) run --rm $(DOCKER_TAG) sh -c \
		'ansible --version | head -1; ansible-galaxy collection list ansible.posix; qemu-img --version | head -1; virt-customize --version'
