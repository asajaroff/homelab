DOCKER_BIN := podman
DOCKER_BUILD_LOG = $(shell echo `date +%F-%T`.log)
DOCKER_BUILD_PARAMS = --platform=linux/arm64 --logfile=$(DOCKER_BUILD_LOG)

build:
	$(DOCKER_BIN) buildx build . \
		--platform=linux/arm64 \
