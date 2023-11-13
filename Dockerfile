FROM golang:1.21 AS base

WORKDIR /app

COPY catgpt .

RUN go mod download

RUN CGO_ENABLED=0 go build -o /app/catgpt


FROM gcr.io/distroless/static-debian12:latest-amd64

WORKDIR /

COPY --from=base /app/catgpt /

EXPOSE 8080
EXPOSE 9090

ENTRYPOINT [ "/catgpt" ]