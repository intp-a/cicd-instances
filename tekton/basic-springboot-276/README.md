## Apply git clone Task
```
$ kubectl apply -f https://raw.githubusercontent.com/tektoncd/catalog/main/task/git-clone/0.4/git-clone.yaml
```

## Apply gradle Task
```
$ kubectl apply -f https://api.hub.tekton.dev/v1/resource/tekton/task/gradle/0.2/raw
```

## Apply buildah Task
```
$ kubectl apply -f https://api.hub.tekton.dev/v1/resource/tekton/task/buildah/0.5/raw
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

## Gradle Clean build Piepeline
```
# Pipeline 생성
$ kubectl apply -f manifests/gradle-build-pipeline.yaml

# Pipeline 실행
$ tkn pipeline start gradle-build-pipeline \
  -w name=pipeline-workspace-tmp,claimName=pipeline-workspace-pvc \
  -p java-repo-url=https://github.com/intp-a/sample-application.git \
  -p java-repo-rev=main \
  -p build-dir=basic-springboot-276
```

## Gradle Clean bootJar Piepeline
```
# Pipeline 생성
$ kubectl apply -f manifests/gradle-boot-jar-pipeline.yaml

# Pipeline 실행
$ tkn pipeline start gradle-boot-jar-pipeline \
  -w name=pipeline-workspace-tmp,claimName=pipeline-workspace-pvc \
  -p java-repo-url=https://github.com/intp-a/sample-application.git \
  -p java-repo-rev=main \
  -p build-dir=basic-springboot-276
```

## Gradle Clean bootBuildImage Piepeline
```
# Pipeline 생성
$ kubectl apply -f manifests/gradle-boot-build-image-pipeline.yaml

# Pipeline 실행
$ tkn pipeline start gradle-boot-build-image-pipeline \
  -w name=pipeline-workspace-tmp,claimName=pipeline-workspace-pvc \
  -p java-repo-url=https://github.com/intp-a/sample-application.git \
  -p java-repo-rev=main \
  -p build-dir=basic-springboot-276
```

## Pipeline 로그 조회
```
$ tkn pipelinerun logs  -f -n default
```