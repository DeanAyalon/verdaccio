# Use the official Verdaccio image as the base
FROM verdaccio/verdaccio

# Expose the port Verdaccio runs on and set verrdaccio protocol to HTTPS
EXPOSE 4873
ENV VERDACCIO_PROTOCOL=https

# Get curl and define healthcheck script
USER root
RUN apk update && apk add curl
HEALTHCHECK --interval=30s --timeout=3s \
    CMD curl -f https://localhost:4873/ || exit 1

# Copy configuration file into container
COPY files/conf/config.yaml /verdaccio/conf/config.yaml
# Copy helper scripts into container
COPY files/scripts/* /verdaccio/scripts/