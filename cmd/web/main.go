package main

import (
	"encoding/gob"
	"fmt"
	"log"
	"net/http"
	"os"
	"time"

	"github.com/davidhalasz/go-bookings/internal/config"
	"github.com/davidhalasz/go-bookings/internal/driver"
	"github.com/davidhalasz/go-bookings/internal/handlers"
	"github.com/davidhalasz/go-bookings/internal/helpers"
	"github.com/davidhalasz/go-bookings/internal/models"
	"github.com/davidhalasz/go-bookings/internal/render"

	"github.com/alexedwards/scs/v2"
)

const portnNumber = ":8080"

var app config.AppConfig
var session *scs.SessionManager
var infoLog *log.Logger
var errorLog *log.Logger

func main() {
	db, err := run()
	if err != nil {
		log.Fatal(err)
	}
	defer db.SQL.Close()

	defer close(app.MailChan)

	fmt.Println("Starting mail listener...")
	listenForMail()

	// msg := models.MailData{
	// 	To:      "John@do.ca",
	// 	From:    "me@here.com",
	// 	Subject: "Some Subject",
	// 	Content: "",
	// }

	// app.MailChan <- msg

	//**********************//
	// mail sending with go //
	//**********************//
	/*
		from := "me@here.com"
		auth := smtp.PlainAuth("", from, "", "localhost")
		err = smtp.SendMail("localhost:1025", auth, from, []string{"you@there.com"}, []byte("Hello, world"))
		if err != nil {
			log.Println(err)
		}
	*/
	//**********************//
	// END //
	//**********************//

	fmt.Println(fmt.Sprintf("Starting application on port %s", portnNumber))

	srv := &http.Server{
		Addr:    portnNumber,
		Handler: routes(&app),
	}

	err = srv.ListenAndServe()
	log.Fatal(err)
}

func run() (*driver.DB, error) {
	// what I am going to put in the session
	gob.Register(models.Reservation{})
	gob.Register(models.User{})
	gob.Register(models.Restriction{})
	gob.Register(models.Room{})

	mailChan := make(chan models.MailData)
	app.MailChan = mailChan

	app.InProduction = false

	infoLog = log.New(os.Stdout, "INFO\t", log.Ldate|log.Ltime)
	app.InfoLog = infoLog

	errorLog = log.New(os.Stdout, "ERROR\t", log.Ldate|log.Ltime|log.Lshortfile)
	app.ErrorLog = errorLog

	session = scs.New()
	session.Lifetime = 24 * time.Hour
	session.Cookie.Persist = true
	session.Cookie.SameSite = http.SameSiteLaxMode
	session.Cookie.Secure = app.InProduction

	app.Session = session

	// connect to DB
	log.Println("Connecting to database...")
	db, err := driver.ConnectSQL("host=localhost port=5432 dbname=bookings user=halaszdavid password=")
	if err != nil {
		log.Fatal("Cannot connect to dabasae!")
	}
	log.Println("Connected to database.")

	tc, err := render.CreateTemplateCache()
	if err != nil {
		log.Fatal("cannot create  template cache")
		return nil, err
	}

	app.TemplateCache = tc
	app.UseCache = false

	repo := handlers.NewRepo(&app, db)
	handlers.NewHandlers(repo)
	render.NewRenderer(&app)
	helpers.NewHelpers(&app)

	return db, nil
}
