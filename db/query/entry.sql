-- name: CreateEntry :one
INSERT INTO entries (account_id, amount)
VALUES ($1, $2)
RETURNING id, account_id, amount, created_at;

-- name: GetEntry :one
SELECT id, account_id, amount, created_at
FROM entries
WHERE id = $1;

-- name: ListEntries :many
SELECT id, account_id, amount, created_at
FROM entries
ORDER BY id DESC
LIMIT $1
OFFSET $2;

-- name: UpdateEntry :one
UPDATE entries
SET amount = $2
WHERE id = $1
RETURNING id, account_id, amount, created_at;

-- name: DeleteEntry :exec
DELETE FROM entries
WHERE id = $1;