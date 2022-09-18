#!/bin/bash

# Show environment variables
# grep -v '^#' .env

# export environment variables
export  $(grep -v '^#' .env | xargs)

# echo $PASSPHRASE

# check wether ca private key already exists
FILE=./ca_key.key
if test -f "$FILE"; then
    echo "ca private key already exists, going to use the existing one"
# if it doesnt exist, create a new one with a passphrase from the .env file
else
    openssl genrsa -aes256 -passout pass:$CA_PASSPHRASE -out ca_key.key
fi

openssl req -x509 -sha256 -days 398 -key ca_key.key -passin pass:$CA_PASSPHRASE -out rootCA.crt -config conf/server.conf

echo ""

# check wether server private key already exists
FILE=./server_key.key
if test -f "$FILE"; then
    echo "server private key already exists, going to use the existing one"
# if it doesnt exist, create a new one with a passphrase from the .env file
else
    openssl genrsa -aes256 -passout pass:$SERVER_PASSPHRASE -out server_key.key
fi

echo ""

openssl req -new -sha256 -nodes -out server.csr -key server_key.key -passin pass:$SERVER_PASSPHRASE -config conf/server.conf
openssl x509 -req -in server.csr -CA rootCA.crt -CAkey ca_key.key -passin pass:$CA_PASSPHRASE -CAcreateserial -out server.crt -days 398 -sha256 -extfile ext/x509_v3_server.ext

echo ""

echo "Verifying certificate..."
openssl verify -CAfile rootCA.crt server.crt