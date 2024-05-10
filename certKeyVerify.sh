#!/bin/bash

usage() { echo "Usage: $0 [-c certificate] [-k key]"; exit 1; }

while getopts ":c:k:" option; do
    case $option in
        c)
            CERT="$OPTARG"
            ;;
        k)
            KEY="$OPTARG"
            ;;
        *)
            usage
            ;;
    esac
done

if [ -z $CERT ] || [ -z $KEY ]; then
    usage
fi

CERT_MOD=`openssl x509 -noout -modulus -in $CERT`
KEY_MOD=`openssl rsa -noout -modulus -in $KEY` &&
CERT_MD5=`echo $CERT_MOD | openssl md5 | cut -c 12-44` &&
KEY_MD5=`echo $KEY_MOD | openssl md5 | cut -c 12-44` &&

if [[ "$CERT_MD5" == "$KEY_MD5" ]]; then
    echo Private key is valid for the certificate.
else
    echo Private key is NOT valid for the certificate.
fi