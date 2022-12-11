FROM golang:1.18.4 as builder

WORKDIR /work
COPY go.mod go.sum ./
RUN go mod download
RUN  make build

FROM gcr.io/distroless/base:debug
COPY --from=builder /work/example-sample-service /bin/example-sample-service
USER nonroot:nonroot
EXPOSE 1323
ENTRYPOINT ["/bin/example-sample-service"]
