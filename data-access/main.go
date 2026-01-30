package main

import (
	"database/sql"
	"fmt"
	"github.com/go-sql-driver/mysql"
	_ "github.com/go-sql-driver/mysql"
	"github.com/joho/godotenv"
	"log"
	"os"
)

// Declare a package-level variable that will hold the database connection.
// *sql.DB is a pooled, concurrency-safe handle to a database.
var db *sql.DB

func main() {
	// make .env variable available
	envErr := godotenv.Load(".env")
	if envErr != nil {
		log.Fatal(envErr)
	}

	// capture connection properties
	cfg := mysql.NewConfig()
	cfg.User = os.Getenv("DBUSER")
	cfg.Passwd = os.Getenv("DBPASS")
	cfg.Net = "tcp" // TCP (Transmission Control Protocol) is a reliable, ordered, error-checked way of sending data between programs over a network.
	cfg.Addr = "127.0.0.1:3306"
	cfg.DBName = "recordings"

	// Create a database handle using the MySQL driver and the formatted DSN
	// (Data Source Name) built from the configuration above.
	// NOTE: sql.Open does NOT actually establish a connection yet.
	// It only prepares the handle.
	var err error
	db, err = sql.Open("mysql", cfg.FormatDSN())
	if err != nil {
		log.Fatal(err)
	}
	defer db.Close()

	// Ping the database to force an actual connection to be made
	// and to verify that the credentials and network settings are valid.
	pingErr := db.Ping()
	if pingErr != nil {
		log.Fatal(pingErr)
	}

	fmt.Println("-- CONNECTED --")

	albums, err := albumsByArtist("John Coltrane")
	if err != nil {
		log.Fatal(err)
	}
	fmt.Printf("Albums found: %v\n", albums)
}

type Album struct {
	ID     int64
	Title  string
	Artist string
	Price  float32
}

// albumsByArtist queries for albums that have the specified artist name
func albumsByArtist(name string) ([]Album, error) {
	var albums []Album

	rows, err := db.Query("SELECT * FROM album WHERE artist = ?", name)
	if err != nil {
		return nil, fmt.Errorf("albumsByArtist %q: %v", name, err)
	}
	defer rows.Close()

	for rows.Next() {
		var alb Album
		// Scan copies the columns from the matched row into the values pointed at by dest.
		if err := rows.Scan(&alb.ID, &alb.Title, &alb.Artist, &alb.Price); err != nil {
			return nil, fmt.Errorf("albumsByArtist %q: %v", name, err)
		}
		albums = append(albums, alb)
	}

	if err := rows.Err(); err != nil {
		return nil, fmt.Errorf("albumsByArtist %q: %v", name, err)
	}

	return albums, nil
}
