package main

import (
	"fmt"
	"html"
	"log"
	"net/http"
)

func main() {
	http.HandleFunc("/hello_world", func(w http.ResponseWriter, r *http.Request) {
		fmt.Fprintf(w, "This is a GO server!  The current path is %q", html.EscapeString(r.URL.Path))
	})
	http.HandleFunc("/hello_world2", func(w http.ResponseWriter, r *http.Request) {
		fmt.Fprintf(w, "This is a GO server!  The current path is %q", html.EscapeString(r.URL.Path))
	})
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		http.ServeFile(w, r, r.URL.Path[1:])
	})

	http.HandleFunc("/static/", func(w http.ResponseWriter, r *http.Request) {
		http.ServeFile(w, r, r.URL.Path[1:])
	})

	log.Fatal(http.ListenAndServe(":3001", nil))

}
