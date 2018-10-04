FROM golang:1.10-alpine3.8 as geth-builder

## install necessary package
RUN apk add --no-cache make gcc musl-dev linux-headers git

## clone go-ethereum
RUN git clone https://github.com/ethereum/go-ethereum.git

## checkout tag
RUN cd ./go-ethereum \
    && git checkout tags/v1.8.16 \
    && cd ..

## build all bins
RUN make --directory=./go-ethereum all
RUN cp ./go-ethereum/build/bin/* ./bin

## build final executable scenario
FROM alpine:latest
COPY --from=geth-builder /go/bin/* /usr/local/bin/