package main

import (
	"io"
	"log"
	"net/http"
	"time"
)

// TimeFormat 时间格式
const TimeFormat = "2006/01/02 15:04:05"

func main() {
	helloHandler := func(w http.ResponseWriter, req *http.Request) {
		//nolint
		io.WriteString(w, time.Now().Format(TimeFormat)+" 你好,暴躁老爸!\n")
	}
	
	certVerifyingHandler := func(w http.ResponseWriter, req *http.Request) {}

	http.HandleFunc("/hello", helloHandler)
	http.HandleFunc("/", certVerifyingHandler)
	log.Fatal(http.ListenAndServe(":80", nil))
}
