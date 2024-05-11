# What is this?
This is the repository managing my own [Verdaccio](https://github.com/verdaccio/verdaccio) server

The server is private and allows no public access, the code is shared for public reference.<br>
This repository is part of the larger [dean-server](https://github.com/DeanAyalon/dean-server) monorepo, and can be ran from there as well as an individual repository.

## Table of Contents

1. [What is this?](#what-is-this)
2. [Running](#running)
   - [Configuration](#configuration)
     - [Environment](#environment)
     - [Standalone - Certificates](#standalone---certificates)
   - [Use](#use)
   - [v1](#v1)
     - [HTTP - Unchecked](#http----unchecked)
3. [Contact](#contact)
4. [Thanks](#thanks)



# Running
## Pre-Running
### Requirements
- Docker Engine or Docker Desktop, with Docker Compose installed (Built in)
    - This repository uses the new `docker compose`, it is unknown how well it would work with legacy `docker-compose` versions

### Environment
`docker compose` uses `.env` to build the containers according to your needs, make sure it's configured, duplicate [template.env](./template.env) to start

### Standalone - Certificates
When running this container without a proxy, Verdaccio needs access to the certificates to serve through HTTPS.
- Use single-domain certificates
- Use fullchain, not cert or chain
- Name the files: `fullchain.pem` and `privkey.pem` within the mount

## Use
Docker compose can be ran from the context of this repository, but it is recommended to use it from the content of the entire [dean-server](https://github.com/DeanAyalon/dean-server) monorepo

### It is recommended to use this repository paired with [dean-nginx](https://github.com/DeanAyalon/dean-nginx)
In order to use this repository without a proxy:
- Enable port mapping
- Enable certificate mounting

The configuration file should work as is.

#### If it does not work, here are your options:
- Open an [issue](https://github.com/DeanAyalon/verdaccio/issues) and I'll get to it, either fixing the config file, or splitting it into proxy/conf and no-proxy/conf if need be
- Fork, fix and open a PR, I'll review and merge with gratitude!
- Use [v1](#v1) - It was configured to run without a proxy, using https 


## v1
v1 of this repository does not use https-proxy, instead exposing port 4873 and setting Verdaccio protocol to HTTPS
> Requires .env variable `$CERTS`

### HTTP -  Unchecked
Unsure, but removing the `VERDACCIO_PROTOCOL` environment variable will set it back to the default value: `http`<br>
This may allow for launching the container with neither proxy, nor https encryption.

> THIS IS NOT RECOMMENDED, ALL COMMUNICATION WILL BE UNENCRYPTED, INCLUDING PASSWORDS AND PRIVATE PACKAGES!
> > Regardless, this will be checked for ease of development



# About me
Hi, I am [Dean Ayalon](https://deanayalon.com), a software developer from Israel.

## Contact Me

Feel free to contact me for any reason, including:
- Insturctions, explanations and help
- Code recommendations and feature requests
- Hiring - As of the current commit, I am looking for a job!

[![GitHub](https://img.shields.io/badge/github-%23121011.svg?style=for-the-badge&logo=github&logoColor=white)](https://github.com/DeanAyalon)
[![LinkedIn](https://img.shields.io/badge/linkedin-%230077B5.svg?style=for-the-badge&logo=linkedin&logoColor=white)](https://deanayalon.com/linkedin)
[![WhatsApp](https://img.shields.io/badge/WhatsApp-25D366?style=for-the-badge&logo=whatsapp&logoColor=white)](https://deanayalon.com/whatsapp)

[Email](mailto:dev@deanayalon.com)<br>
[Phone](https://deanayalon.com/call)<br>

## Thanks
- [evab](https://github.com/eranbraun) - For continuous guidance and support, through all my nagging

## Technologies used
[![NPM](https://img.shields.io/badge/NPM-%23CB3837.svg?style=for-the-badge&logo=npm&logoColor=white)](https://npmjs.com)
[![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)](https://github.com/DeanAyalon/verdaccio/pkgs/container/verdaccio)

[![GitHub Actions](https://img.shields.io/badge/github%20actions-%232671E5.svg?style=for-the-badge&logo=githubactions&logoColor=white)](https://github.com/DeanAyalon/verdaccio/actions)