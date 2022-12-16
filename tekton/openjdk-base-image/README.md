## Apply git clone Task
```
$ kubectl apply -f https://raw.githubusercontent.com/tektoncd/catalog/main/task/git-clone/0.4/git-clone.yaml
```

## Apply kaniko Task
```
$ kubectl apply -f https://api.hub.tekton.dev/v1/resource/tekton/task/kaniko/0.6/raw
```

## Add tmp host path
```
$ mkdir /tmp/tekton-tmp
$ ssh node01 "mkdir /tmp/tekton-tmp"
```

## Workspace 용도 PV, PVC 생성
```
$ kubectl apply -f manifests/pipeline-workspace-pv.yaml
$ kubectl apply -f manifests/pipeline-workspace-pvc.yaml
```

## Pipeline 생성
```
$ kubectl apply -f manifests/openjdk11-build-kaniko-pipeline.yaml
```

## Pipeline 실행 (kaniko)
```
$ tkn pipeline start openjdk11-build-kaniko-pipeline \
  -w name=pipeline-workspace-tmp,claimName=pipeline-workspace-pvc \
  -p image-repo=private-registry-svc.default.svc.cluster.local:5000/openjdk11-build \
  -p image-tag=v0.0.1 \
  -p dockerfile=./tekton/openjdk-base-image/dockerfile/Dockerfile.basic

### Docker Build, Buildah 는 Build를 위한 Container 가 privileged 권한을 가지고 동작해야함
### 보안상 취약할 수 있고, 테스트 환경에서 overlayfs 권한 에러가 날 수 있음
### Docker 안에서 Docker를 수행시키므로 빌드 성능 저하도 발생
```

## Pipeline 로그 조회
```
$ tkn pipelinerun logs  -f -n default
```