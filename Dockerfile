FROM registry.access.redhat.com/ubi8/go-toolset:1.20.12-2 as intermediate
ENV GOFIPS=1
ENV GO111MODULE=on
ENV GOPATH /go
WORKDIR /go/src/github.com/relyt0925/hello-world-multicloud-app/
RUN mkdir -p /tmp/bincache
ADD . /go/src/github.com/relyt0925/hello-world-multicloud-app
RUN go build /go/src/github.com/relyt0925/hello-world-multicloud-app/main.go
RUN mv -f /go/src/github.com/relyt0925/hello-world-multicloud-app/main /tmp/bincache/main

FROM registry.access.redhat.com/ubi8/ubi-minimal:8.9-1137

COPY --from=intermediate /tmp/bincache/main /bin/main
