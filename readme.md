# Creating CA and Server certificates locally

## Use Case
A lot of services i have running locally are accessed using HTTP. Just for the sake of improving my knowledge of openssl and certificate chains i decided on securing those services with HTTPS

## Respository contents

### `.env`-file
The `.env`-file contains environment variables, more specifically the passphrases for the ca, server private-key and the filenames. I strongly suggest chaning the passphrase. Modify the filenames to your liking.


### `conf/server.conf`-file
My Modifications to the default `openssl.conf`-file. The distinguished names are used to fill out the ca-attributes. Change those to meet your requirements.

### `conf/server.conf`-file
Used to incorporate the distinguished names within the csr. Modify it to meet your requirements.

### `ext/x509_v3_server.ext`-file
OpenSSL-extension-file which defines the certificate extensions. Also used to specify the DNS Names. Modify it to match your domains.

## Usage
After modifying above files, simply run `./openssl.sh` to create all certificates