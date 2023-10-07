images:
	@echo "Pulling images..."
	docker pull postgres:12-alpine
	@echo "Images Pulled."

postgres:
	@echo "Starting postgres..."
	@docker run --name postgres12 -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:12-alpine
	@echo "Postgres started."

createdb:
	@echo "Creating database..."
	@docker exec -it postgres12 createdb --username=root --owner=root simple_bank
	@echo "Database created."

dropdb:
	@echo "Dropping database..."
	@docker exec -it postgres12 dropdb simple_bank
	@echo "Database dropped."

migrateup:
	@echo "Running Migrations..."
	@migrate -path db/migration -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose up
	@echo "Migrations ran."

migratedown:
	@echo "Rolling Back Migrations..."
	@migrate -path db/migration -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose down
	@echo "Migrations rolled back."

sqlc:
	@echo "Generating sqlc..."
	@sqlc generate
	@echo "sqlc generated."


.phony: images postgres createdb dropdb migrateup migratedown sqlc
