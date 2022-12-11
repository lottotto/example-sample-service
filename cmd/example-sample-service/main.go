package main

import "example-sample-service/internal/server"

func main() {
	e, err := server.NewHTTPServer()
	if err != nil {
		panic(err)
	}
	e.Logger.Fatal(e.Start(":1323"))
}
