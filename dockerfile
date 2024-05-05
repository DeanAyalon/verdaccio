# Use the official Verdaccio image as the base
FROM verdaccio/verdaccio

# Expose the port Verdaccio runs on and set verrdaccio protocol to HTTPS
EXPOSE 4873

# Get curl and define healthcheck script
USER root
RUN apk update && apk add curl

# Copy files into container
COPY --chown=root:root files/conf/config.yaml /verdaccio/conf/config.yaml
COPY --chown=root:root files/scripts/* /verdaccio/scripts/
# Script execution permissions
# RUN chown root:root /verdaccio/scripts/*
RUN chmod u+x /verdaccio/scripts/*

HEALTHCHECK --interval=10s --timeout=3s \
    CMD /verdaccio/scripts/healthcheck.sh