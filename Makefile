TAG?=1

build:
	docker buildx build . --platform=linux/amd64,linux/arm64 -t ondras/php:$(TAG) --push

create-builder:
	docker buildx create --name mybuilder --driver docker-container --bootstrap

use-builder:
	docker buildx use mybuilder
