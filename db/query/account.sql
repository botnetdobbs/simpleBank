-- name: CreateAccount :one
INSERT INTO accounts (owner, balance, currency) 
VALUES ($1, $2, $3) 
RETURNING id, owner, balance, currency, created_at;

-- name: GetAccount :one
SELECT id, owner, balance, currency, created_at
FROM accounts
WHERE id = $1;

-- name: ListAccounts :many
SELECT id, owner, balance, currency, created_at
FROM accounts
ORDER BY id DESC
LIMIT $1
OFFSET $2;

-- name: UpdateAccount :one
UPDATE accounts
SET balance = $2 
WHERE id = $1
RETURNING id, owner, balance, currency, created_at;

-- name: DeleteAccount :exec
DELETE FROM accounts
WHERE id = $1;