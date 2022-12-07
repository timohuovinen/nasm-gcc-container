build:
	docker compose build

run: build
	docker compose run nasm-gcc

