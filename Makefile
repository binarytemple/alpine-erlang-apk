setup-network:
	docker network create ci || true

setup-apk-cache: setup-network
	docker run --restart always --network ci --name=dl-cdn.alpinelinux.org quay.io/vektorcloud/apk-cache:latest || true

build: setup-apk-cache
	docker build --network ci --tag bryanhuntesl/alpine-erlang-builder .

run:
	docker run  --network ci -ti bryanhuntesl/alpine-erlang-builder
