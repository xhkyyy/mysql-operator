
编译：

1.关闭 mod 模式：`go env -w GO111MODULE=off`


镜像：

docker build . -f Dockerfile -t mysql-operator:latest

docker build . -f Dockerfile.sidecar -t mysql-operator-sidecar:latest

docker build . -f Dockerfile.orchestrator -t mysql-operator-orchestrator:latest

