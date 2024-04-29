docker-compose uses .env, make sure it's configured, use defaults.env as template

Production: `docker compose up -d`

Development: `docker compose watch`
> This will rebuild the image and container for every change within the files directory.<br>
> Exiting watch mode will not take the container down