### 인증서 키 생성
```
openssl genrsa -aes256 -out docker-registry.key 2048
```

### 개인키 Pass Phrase 제거
```
cp  docker-registry.key  docker-registry.key.enc
openssl rsa -in  docker-registry.key.enc -out docker-registry.key
```

### CSR 생성
```
openssl req -new -key docker-registry.key -out docker-registry.csr -config registry_openssl.conf
```

### SSL 인증서 요청
```
openssl x509 -req -days 1825 -extensions v3_user -in docker-registry.csr \
-CA ../rootca/intp-rootca.crt -CAcreateserial \
-CAkey  ../rootca/intp-rootca.key \
-out docker-registry.crt  -extfile registry_openssl.conf
```

### 생성된 인증서 
```
kubectl -n cicd-instances create secret generic docker-registry-certs \
    --from-file=server.crt=docker-registry.crt,server.key=docker-registry.key \
    --type=Opaque
```
