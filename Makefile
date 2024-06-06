.PHONY: up up-bg down down-v
up:
	docker compose up

up-bg:
	docker compose up -d

down:
	docker compose down

down-v:
	docker compose down -v
