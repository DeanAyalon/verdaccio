#!/bin/bash 

# This scripts directory
scripts=$(dirname $(readlink -f $0))

# Certificates directory (argument)
path="$1"
[ -z "$1" ] && path=~/Documents/verdaccio/certs

name=dean-verdaccio
key=$path/$name-key.pem
csr=$path/$name-csr.pem
cert=$path/$name.pem

if [ ! -d "$path" ]; then
    echo "Directory does not exist, creating $path"
    mkdir -p "$path"
fi

# Generate certificate
echo "Generating certificates"
openssl genrsa -out $key 2048
openssl req -new -sha256 -key $key -out $csr -subj "/C=IL/L=Ness Ziona/O=Developer/CN=yourdomain.com/emailAddress=deanayalon@me.com/name=Dean Ayalon"
openssl x509 -req -in $csr -signkey $key -out $cert || exit 1

# CSR file unneeded after generation
rm $csr

# Trust certificate in npm
echo
echo [!] Warning - This will skip validation of SSL certificates and pose as a security risk for all registry interactions!
read -p "Would you like to allow your package manager to trust self-signed certificates? (y/N)" trust
if [[ $trust == [yY] || $trust == [yY][eE][sS] ]]; then
    manager=npm
    read -p "Confirmed, choose package manager: (NPM/yarn)" man
    if [[ $man == [yY] || $man == [yY][aA][rR][nN] ]]; then
        $manager config set strict-ssl false
        # $manager config set cafile $cert
    fi
fi

# Update @dean/trust-verdaccio
# cp "$cert" "$scripts/../trust/$name.pem"

# Trust certificate in system
# echo "Copying to system's trusted certificates"
# trusted=/usr/local/share/ca-certificates
# cp $path/* $trusted
