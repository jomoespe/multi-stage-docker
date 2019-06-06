# ==========================================================================
# Copyright 2019 Jomoespe. All rights reserved.
#
# Use of this source code is governed by a The Unlicense license that can be
# found in the LICENSE file.
# ==========================================================================

repo             := jomoespe
image            := multi-stage-docker
version          := $(shell cat VERSION)
build_date       := $(shell date --rfc-3339=seconds 2> /dev/null || date "+%Y-%m-%dT%H:%M:%SZ")
go_version       := $(shell go version | cut -d " " -f3)
git_version      := $(shell git version | cut -d " " -f3)
git_commit       := $(shell git rev-parse HEAD)
git_commit_short := $(shell git rev-parse --short HEAD)
tag              := $(version)$(git_commit_short:%$(git_commit_short)=-%$(git_commit_short)) # tag=version[-git_commit_short] (if git_commit_short exist)

.PHONY   : build
.DEFAULT : build

build:
	@ docker build --label "maintainer=José Moreno <jomoespe@gmail.com>" \
					--label "version=$(version)" \
					--label "revision=$(git_commit_short)" \
					--label "build-date=$(build_date)" \
					--build-arg version=$(version) \
	                --build-arg revision=$(git_commit_short) \
					--build-arg build_date="$(build_date)" \
					--rm \
					--force-rm \
					--quiet \
					--tag $(repo)/$(image):$(tag) .
	@ docker tag $(repo)/$(image):$(tag) $(repo)/$(image):latest
