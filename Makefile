up:
	docker-compose up -d
stop:
	docker-compose stop
logs:
	docker-compose logs -f
ps:
	docker-compose ps
pull:
	docker-compose pull
down:
	docker-compose down
clean:
	docker-compose down -v

