package db

import (
	"database/sql"
	"fmt"
	"log"
	"os"
	"testing"

	_ "github.com/lib/pq"
)

var testQueries *Queries

const dbDriver = "postgres"
const dbSource = "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable"

func TestMain(t *testing.M) {
	conn, err := sql.Open(dbDriver, dbSource)
	if err != nil {
		log.Fatal("cannot connect to db:", err)
	}

	testQueries = New(conn)
	fmt.Println("connected to db")

	os.Exit(t.Run())
}
