# Maintainer: Varun Sridharan <varunsridharan23@gmail.com>
# Dockerfile version: 1.0

# Use the latest version of Alpine as the base image
FROM alpine:latest

# Update the package manager and install required packages
RUN apk --no-cache update \
    && apk --no-cache add git nodejs npm \
# Create a directory for the app and navigate into it
    && mkdir -p /app/linksnatch \
    && cd /app/linksnatch \
# Clone the linksnatch repository from GitHub
    && git clone https://github.com/amitmerchant1990/linksnatch . \
# Install the required dependencies for the app
    && npm install \
# Remove the git package to reduce image size
    && apk del git \
# Clean up the package cache, git files and node_modules to further reduce image size
    && rm -rf /var/cache/apk/* .git .github \
# Create an entrypoint script for the app
    && echo '#!/bin/sh' > /entrypoint.sh \
    && echo 'cd /app/linksnatch && npm run dev' >> /entrypoint.sh \
    && chmod +x /entrypoint.sh

# Expose port 3000 for the app
EXPOSE 3000/tcp

# Set the entrypoint script for the container
ENTRYPOINT ["/entrypoint.sh"]
