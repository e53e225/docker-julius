VERSION ?= 4.4.2.1

build:
	@docker image build --build-arg VERSION=$(VERSION) --tag e53e225/julius:$(VERSION) .

clean:
	@docker image rm e53e225/julius:$(VERSION)

.PHONY: build clean
