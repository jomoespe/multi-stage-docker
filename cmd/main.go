// Copyright 2018 Jomoespe. All rights reserved.
// Use of this source code is governed by a The Unlicense license that can be 
// found in the LICENSE file.

package main

import "fmt"

const msg = 
`multi-stage-docker build sample
    version:    %s
    revision:   %s
    build date: %s
`

var (
	version   = "local-development"
	revision  = ""
	buildDate = ""
)

func main() {
	fmt.Printf(msg, version, revision, buildDate)
}
