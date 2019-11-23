# Specify node alpine as the base image
FROM node:12-alpine as builder

# Add Tini and setup Node
RUN mkdir -p /home/node/app/node_modules \
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

RUN CI=true npm test
RUN npm run build


FROM nginx:1.17-alpine
EXPOSE 80
COPY --from=builder /home/node/app/build /usr/share/nginx/html
