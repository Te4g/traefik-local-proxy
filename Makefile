generate-certificate: ## Generate certificate
	@mkdir -p certs
	@openssl req -x509 -out certs/traefik.localhost.crt -keyout certs/traefik.localhost.key \
		-newkey rsa:2048 -nodes -sha256 -days 3650 \
		-subj "/CN=traefik.localhost" -extensions EXT -config cert.conf
.PHONY: generate-certificate

trust-certificate-macos: ## Trust certificate
	@sudo security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain certs/traefik.localhost.crt
.PHONY: trust-certificate-macos

install: ## Install the project
	@$(MAKE) generate-certificate
	@$(MAKE) trust-certificate-macos

start: ## Start the project
	@docker compose up -d

stop: ## Stop the project
	@docker compose down

.DEFAULT_GOAL := help
help:
	@grep -E '(^[a-zA-Z_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'
.PHONY: helpdawd
