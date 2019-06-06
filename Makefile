# ==========================================================================
# Copyright 2019 Jomoespe. All rights reserved.
#
# Use of this source code is governed by a The Unlicense license that can be
# found in the LICENSE file.
# ==========================================================================

repo     := jomoespe
image    := multi-stage-docker
version  := $(shell cat VERSION)
revision := $(shell git rev-parse --short HEAD)
date     := $(shell date --rfc-3339=seconds)
tag      := $(version)$(revision:%$(revision)=-%$(revision)) # tag=version[-revision] (if revision exist)

.PHONY   : build
.DEFAULT : build

build: 
	@  docker build --label "maintainer=José Moreno <jomoespe@gmail.com>" \
					--label "version=$(version)" \
					--label "revision=$(revision)" \
					--label "build-date=$(date)" \
					--build-arg version=$(version) \
	                --build-arg revision=$(revision) \
					--build-arg build_date="$(date)" \
					--rm \
					--force-rm \
					--quiet \
					--tag $(repo)/$(image):$(tag) .
	@ docker tag $(repo)/$(image):$(tag) $(repo)/$(image):latest
