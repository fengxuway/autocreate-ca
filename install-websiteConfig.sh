cd /root/ca;
openssl genrsa -aes256 \
      -out intermediate/private/git.intra.weibo.com.key.pem 2048;
chmod 400 intermediate/private/git.intra.weibo.com.key.pem;
openssl req -config intermediate/openssl.cnf \
      -key intermediate/private/git.intra.weibo.com.key.pem \
      -new -sha256 -out intermediate/csr/git.intra.weibo.com.csr.pem;
openssl ca -config intermediate/openssl.cnf \
      -extensions server_cert -days 3650 -notext -md sha256 \
      -in intermediate/csr/git.intra.weibo.com.csr.pem \
      -out intermediate/certs/git.intra.weibo.com.cert.pem;
chmod 444 intermediate/certs/git.intra.weibo.com.cert.pem;
openssl x509 -noout -text \
      -in intermediate/certs/git.intra.weibo.com.cert.pem;
openssl verify -CAfile intermediate/certs/ca-chain.cert.pem \
      intermediate/certs/git.intra.weibo.com.cert.pem;
