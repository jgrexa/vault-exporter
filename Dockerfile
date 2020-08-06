# Build stage
FROM golang:1.14.6-alpine AS builder
COPY ./go.mod vault_exporter/
COPY ./go.sum vault_exporter/
COPY ./main.go vault_exporter/
RUN cd vault_exporter && \
    CGO_ENABLED=0 go build -a -o vault_exporter ./ && \
    chmod +x ./vault_exporter

# FROM alpine:3.12.0
FROM scratch
COPY --from=builder /go/vault_exporter/vault_exporter /vault_exporter
ENTRYPOINT ["/vault_exporter"]
