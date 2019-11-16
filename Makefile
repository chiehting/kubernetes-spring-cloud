.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

build-webclient: webclient/dockerfile ## build web client
	$(call build, webclient, webclient)

build-webservice: webservice/dockerfile ## build web service
	$(call build, webservice, webservice)

build-config: config/dockerfile ## build config
	$(call build, config-server, config)

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
    @docker build -t $1 $2
    @docker images|grep none|awk '{print $$3}'|xargs docker rmi
endef

