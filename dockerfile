# Use the official Verdaccio image as the base
FROM verdaccio/verdaccio

# Copy configuration file into container
COPY files/conf/config.yaml /verdaccio/conf/config.yaml
# Copy helper scripts into container
COPY files/storage/bu.sh /verdaccio/storage/bu.sh
COPY files/storage/clear.sh /verdaccio/storage/clear.sh

# Expose the port Verdaccio runs on
EXPOSE 4873

HEALTHCHECK --interval=30s --timeout=3s \
    CMD curl -f http://localhost:4873/ || exit 1
    # CMD curl -f http://10.100.102.178:4873/ || exit 1
