path=~/Documents/verdaccio/certs

key=$path/verdaccio-key.pem
csr=$path/verdaccio-csr.pem
cert=$path/verdaccio-cert.pem

if [ ! -d "$path" ]; then
    mkdir -p "$path"
fi

# Generate certificate
openssl genrsa -out $key 2048
openssl req -new -sha256 -key $key -out $csr
openssl x509 -req -in $csr -signkey $key -out $cert || exit 1

# Trust certificate in npm
npm config set strict-ssl false
npm config set cafile $cert

# Trust certificate in system
# echo "Copying to system's trusted certificates"
# trusted=/usr/local/share/ca-certificates
# cp $path/* $trusted