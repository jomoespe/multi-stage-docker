FROM golang:1.12.5
ARG version
ARG revision
ARG build_date
ENV CGO_ENABLED=0 
ENV GOOS=linux
WORKDIR /go/src/multi-stage-docker
COPY cmd/main.go ./cmd/main.go
RUN go build -ldflags "-s -w -X 'main.version=$version' -X 'main.revision=$revision' -X 'main.buildDate=$build_date'" \
             -a -installsuffix cgo \
             -o main cmd/main.go

FROM scratch
WORKDIR /
COPY --from=0 /go/src/multi-stage-docker/main .
CMD ["./main"] 
