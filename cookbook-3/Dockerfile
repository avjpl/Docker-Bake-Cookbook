FROM golang:1-alpine3.23 AS builder

WORKDIR /app

COPY server.go .

RUN go build -o server server.go

FROM alpine:latest

WORKDIR /app

COPY --from=builder /app/server .

RUN echo "Build for: $(uname -m)" > /platform.txt

CMD ["./server"]
