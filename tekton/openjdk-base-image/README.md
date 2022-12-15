## Apply git clone Task
```
$ kubectl apply -f https://raw.githubusercontent.com/tektoncd/catalog/main/task/git-clone/0.4/git-clone.yaml
```

## Apply buildah Task
```
$ kubectl apply -f https://api.hub.tekton.dev/v1/resource/tekton/task/buildah/0.5/raw
```

## Add tmp host path
```
$ mkdir /tmp/tekton-tmp
```

## Workspace 용도 PV, PVC 생성
```
$ kubectl apply -f pipeline-workspace*.yaml
```

## Pipeline 실행
```
$ tkn pipeline start openjdk11-base-image-pipeline \
  -w name=pipeline-workspace-tmp,claimName=pipeline-workspace-pvc \
  -p image-repo=private-registry-svc.default.svc.cluster.local:5000/openjdk11-base-image
```

## Pipeline 로그 조회
```
tkn pipelinerun logs  -f -n default
```