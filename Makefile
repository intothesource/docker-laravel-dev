build: build_7.2

build_7.2:
	docker build -t intothesource/laravel-dev:7.2 7.2

release: release_7.2

release_7.2:
	docker push intothesource/laravel-dev:7.2
