FROM golang:1.10-alpine as geth-builder

## install necessary package
RUN apk add --no-cache make gcc musl-dev linux-headers git

## build geth
RUN git clone https://github.com/ethereum/go-ethereum.git
RUN make --directory=./go-ethereum all
RUN cp ./go-ethereum/build/bin/* ./bin

## build final executable scenario
FROM alpine:latest
COPY --from=geth-builder /go/bin/* /usr/local/bin/