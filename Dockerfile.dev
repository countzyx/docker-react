# Specify node alpine as the base image
FROM node:12-alpine

# Add Tini and setup Node
RUN apk add --no-cache tini \
  && mkdir -p /home/node/app/node_modules \
  && chown -R node:node /home/node/app \
  && rm -rf /var/cache/apk/*

# Go to app directory and use app user
WORKDIR /home/node/app
USER node

# Install some dependencies
COPY package*.json ./
RUN npm install

# Copy over app code
COPY --chown=node:node . .

# Tini is now available at /sbin/tini
ENTRYPOINT ["/sbin/tini", "--"]

# Default command
CMD ["npm", "start"]