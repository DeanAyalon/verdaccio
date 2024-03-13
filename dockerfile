# Use the official Verdaccio image as the base
FROM verdaccio/verdaccio

# Copy configuration file into container
COPY files/conf/config.yaml /verdaccio/conf/config.yaml
# Copy helper scripts into container
COPY files/storage/bu.sh /verdaccio/storage/bu.sh
COPY files/storage/clear.sh /verdaccio/storage/clear.sh

# Expose the port Verdaccio runs on
EXPOSE 4873

HEALTHCHECK --interval=30s --timeout=10s \
    CMD curl -f http://deanayalon.com:4873/ || exit 1
