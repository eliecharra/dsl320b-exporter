FROM golang:1.14-alpine as build

WORKDIR /go/src/github.com/eliecharra/dsl320B-exporter

COPY go.mod .
COPY go.sum .
RUN go mod download
ADD . .
RUN ./build.sh

FROM gcr.io/distroless/base-debian10
COPY --from=build /go/src/github.com/eliecharra/dsl320B-exporter/dsl320b-exporter /bin
ENTRYPOINT [ "dsl320b-exporter" ]
