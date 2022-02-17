openssl genrsa -aes256 -out intp-rootca.key 2048

openssl req -new -key intp-rootca.key -out intp-rootca.csr -config rootca_openssl.conf

openssl x509 -req -days 3650 \
-extensions v3_ca \
-set_serial 1 \
-in intp-rootca.csr \
-signkey intp-rootca.key \
-out intp-rootca.crt \
-extfile rootca_openssl.conf

openssl x509 -text -in intp-rootca.crt
