REGISTRY := quay.io/presslabs
IMAGE_NAME := wordpress-bedrock-demo
IMAGE_TAGS ?= canary
BUILD_TAG := build
GIT_COMMIT := $(shell git rev-parse HEAD)

# Docker image targets
######################
.PHONY: images
images:
	docker build --pull \
		--build-arg VCS_REF=$(GIT_COMMIT) $(build_args) \
		-t $(REGISTRY)/$(IMAGE_NAME):$(BUILD_TAG) \
		-f ./Dockerfile .
	set -e; \
		for tag in $(IMAGE_TAGS); do \
			docker tag $(REGISTRY)/$(IMAGE_NAME):$(BUILD_TAG) $(REGISTRY)/$(IMAGE_NAME):$${tag}; \
	done

.PHONY: publish
publish:
	set -e; \
		for tag in $(IMAGE_TAGS); do \
		docker push $(REGISTRY)/$(IMAGE_NAME):$${tag}; \
	done
