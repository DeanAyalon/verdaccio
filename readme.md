docker-compose uses .env, make sure it's configured, use template.env
- Production: `docker compose up -d`
- Development: `docker compose watch`
> This will rebuild the image and container for every change within the files directory.<br>
> Exiting watch mode will not take the container down

## v1
v1 does not use https-proxy, instead exposing port 4873 and setting Verdaccio protocol to HTTPS
> Requires .env variable `$CERTS`