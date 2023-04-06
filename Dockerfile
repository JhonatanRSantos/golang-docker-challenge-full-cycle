FROM golang:1.20 AS go-builder

WORKDIR /app

COPY . .
RUN mkdir build
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o build/app cmd/main.go

FROM scratch
WORKDIR /app

COPY --from=go-builder /app/build .
ENTRYPOINT [ "./app" ]