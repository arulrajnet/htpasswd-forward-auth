package main

import (
	"fmt"
	"os"
	"runtime"

	log "github.com/arulrajnet/htpasswd-forward-auth/pkg/logger"
	"github.com/arulrajnet/htpasswd-forward-auth/pkg/version"
	"github.com/spf13/pflag"
)

var logger = log.GetLogger()

func main() {
	configFlagSet := pflag.NewFlagSet("htpasswd-forward-auth", pflag.ContinueOnError)

	configFlagSet.ParseErrorsWhitelist.UnknownFlags = true

	showVersion := configFlagSet.Bool("version", false, "print version string")
	configFlagSet.Parse(os.Args[1:])

	if *showVersion {
		fmt.Printf("htpasswd-forward-auth %s (built with %s)\n", version.VERSION, runtime.Version())
		return
	}

}
