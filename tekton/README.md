## Tekton Resource 및 Dashboard 설치
```
# Tekton Resource 설치
$ kubectl apply --filename https://storage.googleapis.com/tekton-releases/pipeline/latest/release.yaml

# Tekton Dashboard 설치
$ kubectl apply --filename https://github.com/tektoncd/dashboard/releases/latest/download/tekton-dashboard-release.yaml
```

## Tekton CLI 설치
```
# Get the tar.xz
$curl -LO https://github.com/tektoncd/cli/releases/download/v0.28.0/tkn_0.28.0_Linux_x86_64.tar.gz

# Extract tkn to your PATH (e.g. /usr/local/bin)
$sudo tar xvzf tkn_0.28.0_Linux_x86_64.tar.gz -C /usr/local/bin/ tkn
```