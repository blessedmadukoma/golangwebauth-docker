FROM golang:1.16.3-alpine AS builder

RUN mkdir /build
ADD go.mod go.sum main.go /build/
WORKDIR /builld
RUN go build

FROM alpine
RUN adduser -S -D -H -h /app appuser
USER appuser
COPY --from=builder /build/go-jwt-docker /app/
COPY templates/ app/templates
COPY static/ app/static
COPY css/ app/css
WORKDIR /app
CMD [ "./go-jwt-docker" ]