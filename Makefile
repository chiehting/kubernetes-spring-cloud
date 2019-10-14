.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

build-webclient: export service=webclient
build-webclient: build.yml ## build web client
	$(call build)

build-webservice: export service=webservice
build-webservice: build.yml ## build web service
	$(call build)

build-gateway: export service=gateway
build-gateway: build.yml ## build web service
	$(call build)

build-eureka: export service=eureka
build-eureka: build.yml ## build eureka
	$(call build)

build-config: export service=config
build-config: build.yml ## build config
	$(call build)

up:
	$(call docker-compose,up -d)

down:
	$(call docker-compose,down)

ps:
	$(call docker-compose,ps)

logs:
	$(call docker-compose,logs -f --tail 100)

.PHONY: du
du:
	@make down
	@make up

.PHONY: dul
dul:
	@make du
	@make logs

define docker-compose
    @docker-compose -f docker-compose.yml $1;
endef

define build
    @docker-compose -f build.yml up maven
    @docker-compose -f build.yml down
endef

