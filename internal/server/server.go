package server

import (
	"net/http"

	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
)

type helloMessage struct {
	Hello string `json:"hello"`
}

func NewHTTPServer() (*echo.Echo, error) {
	e := echo.New()
	e.Use(middleware.Logger())
	e.Use(middleware.Recover())
	e.GET("/", rootHandler)

	return e, nil
}

func rootHandler(c echo.Context) error {
	msg := &helloMessage{Hello: "world"}
	if err := c.Bind(msg); err != nil {
		return err
	}
	return c.JSON(http.StatusOK, msg)
}
