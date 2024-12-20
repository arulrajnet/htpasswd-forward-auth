package main

import (
	log "github.com/arulrajnet/htpasswd-forward-auth/pkg/logger"
)

var logger = log.GetLogger()

func main() {
	logger.Info().Msg("Hello, World!")
}
