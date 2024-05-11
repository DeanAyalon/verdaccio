FROM verdaccio/verdaccio:5.30.3
EXPOSE 4873

# Get curl for healthcheck
USER root
RUN apk update && apk add curl

# Copy scripts into container and allow execution
COPY --chown=root:root files/scripts/* /verdaccio/scripts/
RUN chmod u+x /verdaccio/scripts/*

# Switch user
# USER $VERDACCIO_USER_UID
# USER verdaccio
# ^ Both these options crash the container on startup, exit code 2, no logs, no errors

HEALTHCHECK --interval=30s --timeout=3s \
    CMD /verdaccio/scripts/healthcheck.sh