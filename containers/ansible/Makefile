# Standard vars
NAME		:= ansible-bin
VERSION		:= 0.0.1
REGISTRY	:= docker.io/asajaroff/$(NAME)

# Docker Vars
DOCKER_BIN 			:= podman
DOCKER_TAG 			:= $(REGISTRY):${VERSION}
DOCKER_BUILD_LOG 	= $(shell echo `date +%F-%T`.log)
DOCKER_BUILD_PARAMS = --logfile=$(DOCKER_BUILD_LOG)

build:
	$(DOCKER_BIN) buildx build . \
		-t $(DOCKER_TAG) \
		--platform=linux/amd64 \
		--load

push:
	$(DOCKER_BIN) push $(DOCKER_TAG)
