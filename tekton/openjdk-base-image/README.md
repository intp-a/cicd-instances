## Apply git clone Task
```
$ kubectl apply -f https://raw.githubusercontent.com/tektoncd/catalog/main/task/git-clone/0.4/git-clone.yaml
```

## Apply buildah Task
```
$ kubectl apply -f https://api.hub.tekton.dev/v1/resource/tekton/task/buildah/0.5/raw
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
$ kubectl apply -f manifests/openjdk11-base-image-pipeline.yaml
$ kubectl apply -f manifests/openjdk11-base-image-kaniko-pipeline.yaml
```

## Pipeline 실행 (buildah)
```
$ tkn pipeline start openjdk11-base-image-pipeline \
  -w name=pipeline-workspace-tmp,claimName=pipeline-workspace-pvc \
  -p image-repo=private-registry-svc.default.svc.cluster.local:5000/openjdk11-base-image
```

## Pipeline 실행 (kaniko)
```
$ tkn pipeline start openjdk11-base-image-kaniko-pipeline \
  -w name=pipeline-workspace-tmp,claimName=pipeline-workspace-pvc \
  -p image-repo=private-registry-svc.default.svc.cluster.local:5000/openjdk11-base-image
```

## Pipeline 로그 조회
```
$ tkn pipelinerun logs  -f -n default
```