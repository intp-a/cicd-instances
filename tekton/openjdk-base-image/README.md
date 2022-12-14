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
