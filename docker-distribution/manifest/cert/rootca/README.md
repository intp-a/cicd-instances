### ROOT CA Key 생성
```
openssl genrsa -aes256 -out intp-rootca.key 2048
```

### ROOT CA Key CSR 생성
```
openssl req -new -key intp-rootca.key -out intp-rootca.csr -config rootca_openssl.conf
```

### ROOT CA 인증서 생성
```
openssl x509 -req -days 3650 \
-extensions v3_ca \
-set_serial 1 \
-in intp-rootca.csr \
-signkey intp-rootca.key \
-out intp-rootca.crt \
-extfile rootca_openssl.conf
```

### 생성된 인증서 확인
```
openssl x509 -text -in intp-rootca.crt
```
