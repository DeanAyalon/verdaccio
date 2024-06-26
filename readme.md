# Archive
This repository is now archived! It is no longer maintained or updated, but it is working as of July 1st, 2024.<br>
Although the repository is not active, you may still contact me about questions, modifications, etc.<br>
The reason for deprecating this repository is migration to [onedev](https://onedev.io)

# What is this?
This is the repository managing my own [Verdaccio](https://github.com/verdaccio/verdaccio) server

The server is private and allows no public access, the code is shared for public reference.<br>
This repository is part of the larger [dean-server](https://github.com/DeanAyalon/dean-server) monorepo, and can be ran from there as well as an individual repository.

# Using this Repo
## Requirements
- Docker Engine or Docker Desktop, with Docker Compose installed (Built in)
    - This repository uses the new `docker compose`, it is unknown how well it would work with legacy `docker-compose` versions

### Environment
`docker compose` uses `.env` to build the containers according to your needs, make sure it's configured, duplicate [template.env](./template.env) to start

> healthcheck.sh calls the following url: 
> `https://$DOMAIN:$PROXY_PORT`
> If PROXY_PORT is undefined, HOST_PORT will be used, or 4873 as default.

### Configuration
If you are not me, and want to fork this repository, make sure to [configure verdaccio](./mounts/live/conf/config.yaml) for your own needs.<br>
By default, only a single user is allowed to register, and package access is specifically configured for my own use.

- To run without a proxy, see [alternate configurations](#alternate-configuration)

## Run
Docker compose can be ran from the context of this repository, but it is recommended to use it from the content of the entire [dean-server](https://github.com/DeanAyalon/dean-server) monorepo

**It is recommended to use this repository paired with [dean-nginx](https://github.com/DeanAyalon/dean-nginx) or your own version of [nginx-proxy](https://github.com/nginx-proxy/nginx-proxy)**

### Profile
There are three configured profiles:
- **live** - Production service as used on my server
- **dev** - Development service that can be used in parallel with production
- **beta** - Beta version using the next Verdaccio, unstable, for testing purposes

## Use
After running, use Verdaccio as you would with npm, simply add `--registry=<url>`
> ex. `npm --registry=https://verdaccio.deanayalon.com publish my-package`
Any package not within the registry will be proxied to https://npmjs.com

## Alternate Configuration

### No Proxy
In order to use this repository without a proxy:
- Enable port mapping
- Enable certificate mounting

The configuration file should work as is.<br>

> The problem with running Verdaccio without proxy is that it caches its html for an hour. This makes the webserver only work for the first url requested.<br>
> Therefore, it is recommended setting the healthcheck interval to 10s and building a new image, so that the correct url will be locked right away.

### HTTP -  Unrecommended
Unsure, but opening port 4873 and setting the `VERDACCIO_PROTOCOL` environment variable to `http` may allow for launching the container with neither proxy, nor https encryption.

> THIS IS NOT RECOMMENDED, ALL COMMUNICATION WILL BE UNENCRYPTED, INCLUDING PASSWORDS AND PRIVATE PACKAGES!
> > Regardless, this possibility will be checked for ease of local development

**⚠️ SSL certificates can be issued to an IP if no domain is available - So HTTPS is always possible for development purposes as well!**
## Thanks
- [evab](https://github.com/eranbraun) - For continuous guidance and support, through my constant nagging

## Featured Technologies
[![Verdaccio](https://img.shields.io/badge/Verdaccio-4B5E40.svg?style=for-the-badge&logo=verdaccio&logoColor=white)](https://github.com/verdaccio/verdaccio)
[![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)](https://github.com/DeanAyalon/verdaccio/pkgs/container/verdaccio)

[![NPM](https://img.shields.io/badge/NPM-%23CB3837.svg?style=for-the-badge&logo=npm&logoColor=white)](https://npmjs.com)
![Shell](https://img.shields.io/badge/shell-%23121011.svg?style=for-the-badge&logo=gnu-bash&logoColor=white)
[![GitHub Actions](https://img.shields.io/badge/github-actions-%232671E5.svg?style=for-the-badge&logo=githubactions&logoColor=white)](https://github.com/DeanAyalon/verdaccio/actions)
