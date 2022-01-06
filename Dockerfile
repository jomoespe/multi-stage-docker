# ==========================================================================
# Copyright 2019 Jomoespe. All rights reserved.
#
# Use of this source code is governed by a The Unlicense license that can be
# found in the LICENSE file.
# ==========================================================================

# ----------------------------------------------------------------------
# First stage: build the binary program
# ----------------------------------------------------------------------
FROM golang:1.17.5 AS builder
ARG version
ARG revision
ARG build_date
ENV CGO_ENABLED=0
ENV GOOS=linux
WORKDIR /go/src/multi-stage-docker
COPY . ./
RUN go test ./...
RUN go build -ldflags "-s -w -X 'main.version=$version' -X 'main.revision=$revision' -X 'main.buildDate=$build_date'" \
             -a \
             -installsuffix cgo \
             -o main \
             cmd/main.go

# ----------------------------------------------------------------------
# Second stage: build the container for binary built in previous stage
# ----------------------------------------------------------------------
FROM scratch
WORKDIR /
COPY --from=builder /go/src/multi-stage-docker/main .
ENTRYPOINT ["./main"]
