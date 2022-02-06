PHP_VERSION ?= 8.0
PHP_DEBUG ?= 0
PHP_ZTS ?=0
PHP_DMALLOC ?=0

TAG := "$(PHP_VERSION)"

ifeq ($(PHP_DEBUG),1)
	TAG := $(TAG)-debug
endif

ifeq ($(PHP_ZTS),1)
	TAG := $(TAG)-zts
endif

.PHONY: build-php
build-php8.0:
	@echo $(TAG)
	@docker build \
		--build-arg DEBUG=$(PHP_DEBUG) \
		--build-arg ZTS=$(PHP_ZTS) \
		--build-arg DMALLOC=$(PHP_DMALLOC) \
		--build-arg PHP_VERSION=$(PHP_VERSION) \
		--tag brossquad/php-ext-dev:$(TAG) \
		--compress \
		.
