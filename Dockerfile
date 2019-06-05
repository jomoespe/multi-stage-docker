FROM golang:1.12.5
ARG version
ARG revision
ARG build_date
WORKDIR /go/src/github.com/jomoespe/multi-stage-docker
COPY cmd/main.go ./cmd/main.go
RUN CGO_ENABLED=0 GOOS=linux go build  -ldflags "-X 'main.version=$version' -X 'main.revision=$revision' -X 'main.buildDate=$build_date'" -a -installsuffix cgo -o main cmd/main.go

FROM scratch
WORKDIR /
COPY --from=0 /go/src/github.com/jomoespe/multi-stage-docker/main .
CMD ["./main"] 
