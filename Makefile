repo     := jomoespe
image    := sample
version  := $(shell cat VERSION)
revision := $(shell git rev-parse --short HEAD)
date     := "$(shell date --rfc-3339=seconds)"
tag      := $(version)$(revision:%$(revision)=-%$(revision)) # tag=version[-revision] (if revision exist)

build: 
	@  docker build --build-arg version=$(version) \
	                --build-arg revision=$(revision) \
					--build-arg build_date=$(date) \
					--tag $(repo)/$(image):$(tag) .
	@ docker tag $(repo)/$(image):$(tag) $(repo)/$(image):latest

run:
	@ go run cmd/main.go