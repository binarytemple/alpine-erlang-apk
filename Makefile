setup-network:
	docker network ls | awk '!/NET/{print $$2}' | grep ci > /dev/null

setup-volume:
	docker volume ls | grep 'apk_cache$$' > /dev/null || docker volume create apk_cache

setup-apk-cache: setup-network setup-volume
	docker ps \
		|awk '{print $$2}' \
		|egrep 'quay.io/vektorcloud/apk-cache:.*$$' > /dev/null \
		|| docker run -d --rm \
				--network ci \
				--volume apk_cache:/srv/www \
				--name=dl-cdn.alpinelinux.org quay.io/vektorcloud/apk-cache:latest

build: setup-apk-cache
	docker build --network ci --tag bryanhuntesl/alpine-erlang-builder .

run: build
	docker run --network ci -ti bryanhuntesl/alpine-erlang-builder 

extract: build
	docker run -v $(shell pwd):/target --network ci -ti bryanhuntesl/alpine-erlang-builder cp -pr ./packages /target/
