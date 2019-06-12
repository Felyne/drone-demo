# 编译阶段
FROM 192.168.41.34/pub/golang:1.12 as builder
WORKDIR /app
COPY . .
RUN  CGO_ENABLED=0 GOPROXY=http://192.168.40.131:4000 go build -o cmd main/main.go
# 运行阶段
FROM 192.168.41.34/pub/alpine:latest as runner
ARG GIT_TAG
ARG GIT_COMMIT
ARG TIME
LABEL git_tag=$GIT_TAG \
      git_commit=$GIT_COMMIT \
      time=$TIME \
      description="the image is a demo"
WORKDIR /app
COPY --from=builder /app/cmd ./
EXPOSE 8080
ENTRYPOINT ["./cmd"]