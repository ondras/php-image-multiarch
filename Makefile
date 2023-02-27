TAG?=1.1
PLATFORM?=linux/amd64,linux/arm64

build-push:
	docker buildx build . --platform=$(PLATFORM) -t ondras/php:$(TAG) --push

build:
	docker buildx build . --platform=$(PLATFORM) -t ondras/php:$(TAG)

create-builder:
	docker buildx create --name mybuilder --driver docker-container --bootstrap

use-builder:
	docker buildx use mybuilder
