package server

import (
	"net/http"
	"net/http/httptest"
	"testing"

	"github.com/stretchr/testify/require"
)

func TestSimpleHTTPRequest(t *testing.T) {
	e, err := NewHTTPServer()
	require.NoError(t, err)
	testServer := httptest.NewServer(e.Server.Handler)
	t.Cleanup(func() {
		testServer.Close()
	})
	req := httptest.NewRequest(http.MethodGet, "/", nil)
	rec := httptest.NewRecorder()
	e.ServeHTTP(rec, req)
	require.Equal(t, http.StatusOK, rec.Code)

}
