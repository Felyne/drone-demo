# 注意 git_tag表示最近的tag(这个tag不一定对应最新的commit)，如果没有git tag, 则会取最新commit的前几位
git_tag=$(shell if [ "`git describe --tags --abbrev=0 2>/dev/null`" != "" ];then git describe --tags --abbrev=0; else git log --pretty=format:'%h' -n 1; fi)
git_commit=`git rev-parse HEAD`
time=`date +%FT%T%z`

binary=cmd
image_name=192.168.41.34/dev/demo
image_now=${image_name}:${git_tag}
image_latest=${image_name}:latest

# @符号表示不打印命令
default: gotool
	@CGO_ENABLED=0 go build -o ${binary} main/main.go

linux: gotool
	@CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o ${binary} main/main.go

clean:
	rm -f ${binary}
	find . -name "[._]*.s[a-w][a-z]" | xargs -i rm -f {}

gotool:
	@gofmt -w .

docker:
	docker build \
	  --build-arg TIME=${time} \
	  --build-arg GIT_TAG=${git_tag} \
	  --build-arg GIT_COMMIT=${git_commit} \
	  -t ${image_now} .
	docker tag ${image_now} ${image_latest}
	# docker login -u dev-user -p Dev111111 192.168.41.34
	# docker push ${image_now}
	# docker push ${image_latest}
	-docker rm -f demo-test || true
	docker run --name=demo-test -d -p 8002:8080 ${image_now}

help:
	@echo "make         :compile the source code"
	@echo "make linux   :compile the source code for linux"
	@echo "make clean   :remove binary file and vim swp files"
	@echo "make gotool  :run go tool 'fmt' and 'vet'"
	@echo "make docker  :docker build and docker push image"


.PHONY: linux clean gotool docker help
