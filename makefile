VERSION=v$(shell date -u +"%Y-%m-%d.%H%M")

.PHONY: build
build:
	docker build --pull -t moov/about:$(VERSION) -f Dockerfile .
	docker tag moov/about:$(VERSION) moov/about:latest

.PHONY: run
run:
	mkdir -p ./nginx/cache/ ./nginx/run/
	docker run --read-only --tmpfs /tmp -p 8080:8080 -v $(shell pwd)/nginx/cache/:/var/cache/nginx -v $(shell pwd)/nginx/run/:/var/run moov/about:$(VERSION)

.PHONY: release-push
release-push:
	docker push moov/about:$(VERSION)
	docker push moov/about:latest

# From https://github.com/genuinetools/img
.PHONY: AUTHORS
AUTHORS:
	@$(file >$@,# This file lists all individuals having contributed content to the repository.)
	@$(file >>$@,# For how it is generated, see `make AUTHORS`.)
	@echo "$(shell git log --format='\n%aN <%aE>' | LC_ALL=C.UTF-8 sort -uf)" >> $@

.PHONY: tag
tag:
	git tag $(VERSION)
	git push origin $(VERSION)
