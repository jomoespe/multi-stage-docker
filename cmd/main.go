// Copyright 2018 Jomoespe. All rights reserved.
// Use of this source code is governed by a The Unlicense license that can be 
// found in the LICENSE file.

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
