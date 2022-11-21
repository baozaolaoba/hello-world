############################
# STEP 1 build executable binary
############################
FROM golang:1.18-alpine AS builder
LABEL maintainer="BaoZaoLaoBa<release4go@outlook.com>"
WORKDIR /baozaolaoba
COPY . /baozaolaoba/

ARG GOOS=linux
ARG GOARCH=amd64
ARG CGO_ENABLED=0
RUN GOOS=${GOOS} GOARCH=${GOARCH} CGO_ENABLED=${CGO_ENABLED} go build -ldflags="-w -s" -o /baozaolaoba/out .


############################
# STEP 2 build a small image
############################
FROM scratch
LABEL maintainer="BaoZaoLaoBa<release4go@outlook.com>"
WORKDIR /baozaolaoba

COPY --from=builder /baozaolaoba/out /baozaolaoba/out

# expose port
EXPOSE 8022/TCP
ENTRYPOINT [ "/baozaolaoba/out" ]
