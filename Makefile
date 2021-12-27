mdb-up:
	echo "Starting Mongo ..."
	docker compose -f docker-compose.yml up

mdb-up-detached:
	echo "Starting Mongo ..."
	docker compose -f docker-compose.yml up -d

mdb-down:
	echo "Stopping Mongo ..."
	docker compose -f docker-compose.yml down

mdb-verify-script:
	echo "Verify Docker script ..."
	docker compose -f docker-compose.yml config
