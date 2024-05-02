# Use the official Verdaccio image as the base
FROM verdaccio/verdaccio

# Expose the port Verdaccio runs on and set verrdaccio protocol to HTTPS
EXPOSE 4873

# Get curl and define healthcheck script
USER root
RUN apk update && apk add curl

# Copy files into container
COPY --chown=$VERDACCIO_USER_UID:root files/conf/config.yaml /verdaccio/conf/config.yaml
COPY --chown=$VERDACCIO_USER_UID:root files/scripts/* /verdaccio/scripts/
# Script execution permissions
RUN chmod u+x /verdaccio/scripts/*

# Added this, in case the verdaccio user crashes due to having no access to the verdaccio dir
## It did not solve the problem
RUN chown $VERDACCIO_USER_UID:root -R /verdaccio

# When this step is enabled, the contianer immediately exits with code 2, no logs, no errors
# USER $VERDACCIO_USER_UID
# This step is to avoid the root privileges warning - Verdaccio runs perfectly without it

HEALTHCHECK --interval=30s --timeout=3s \
    CMD /verdaccio/scripts/healthcheck.sh