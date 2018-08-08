package main

import (
	"net/http"
	"log"
)

func main(){
    log.Println("Server starting...")
	http.HandleFunc("/",getHeader)
	err := http.ListenAndServe(":8080", nil)
	if err != nil {
		panic(err)
	}
}

func getHeader(w http.ResponseWriter, r *http.Request) {
	for k,v :=range r.Header {
		log.Printf("%s: %s",k,v)
	}
	log.Println("===============================================")
	w.Write([]byte("success"))
}
