package main

import "fmt"

var (
	version   = "development"
	revision  = ""
	buildDate = ""
)

func main() {
	fmt.Printf("multi-stage-docker sample %s %s (%s)\n", version, revision, buildDate)
}
