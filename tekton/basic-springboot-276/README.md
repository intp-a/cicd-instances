## Apply Tekton Tasks
```
kubectl apply -f https://raw.githubusercontent.com/tektoncd/catalog/main/task/git-clone/0.4/git-clone.yaml
kubectl apply -f https://api.hub.tekton.dev/v1/resource/tekton/task/gradle/0.2/raw
kubectl apply -f https://api.hub.tekton.dev/v1/resource/tekton/task/kaniko/0.6/raw
kubectl apply -f https://api.hub.tekton.dev/v1/resource/tekton/task/helm-upgrade-from-source/0.3/raw

### kubectl apply -f https://api.hub.tekton.dev/v1/resource/tekton/task/helm-upgrade-from-repo/0.2/raw
### kubectl apply -f https://api.hub.tekton.dev/v1/resource/tekton/task/kubernetes-actions/0.2/raw
```

## Add tmp host path
```
mkdir /tmp/tekton-tmp
#ssh node01 "mkdir /tmp/tekton-tmp"
```

## Workspace 용도 PV, PVC 생성
```
kubectl apply -f manifests/pipeline-workspace-pv.yaml
kubectl apply -f manifests/pipeline-workspace-pvc.yaml
```

## Gradle Clean build Piepeline
```
# Pipeline 생성
kubectl apply -f manifests/gradle-build-pipeline.yaml
kubectl apply -f manifests/from-gradle-to-deploy-pipeline.yaml

## Pipeline 실행 (kaniko)
```
tkn pipeline start gradle-build-pipeline \
  -w name=pipeline-workspace-tmp,claimName=pipeline-workspace-pvc \
  -p java-repo-url=https://github.com/intp-a/sample-application.git \
  -p java-repo-rev=main \
  -p build-dir=basic-springboot-276 \
  -p image-name=private-registry-svc.default.svc.cluster.local:5000/basic-springboot-276 \
  -p image-tag=v0.0.1 \
  -p dockerfile=./basic-springboot-276/dockerfile/Dockerfile

### Docker Build, Buildah 는 Build를 위한 Container 가 privileged 권한을 가지고 동작해야함
### 보안상 취약할 수 있고, 테스트 환경에서 overlayfs 권한 에러가 날 수 있음
### Docker 안에서 Docker를 수행시키므로 빌드 성능 저하도 발생
```

## Pipeline 실행 (deploy 까지)
```
tkn pipeline start from-gradle-to-deploy-pipeline \
  -w name=pipeline-workspace-tmp,claimName=pipeline-workspace-pvc \
  -p java-repo-url=https://github.com/intp-a/sample-application.git \
  -p java-repo-rev=main \
  -p build-dir=basic-springboot-276 \
  -p image-name=private-registry-svc.default.svc.cluster.local:5000/basic-springboot-276 \
  -p image-tag=v0.0.1 \
  -p dockerfile=./basic-springboot-276/dockerfile/Dockerfile.public \
  -p chart-repo-url=https://github.com/intp-a/helm-charts.git \
  -p chart-repo-rev=main \
  -p release-name=basic-springboot-276
```

## Pipeline 로그 조회
```
tkn pipelinerun logs  -f -n default
```