# Dockerfile
FROM node:11.13.0-alpine

ARG SOURCE_DIR=/opt/gofundme-webui

# create destination directory
RUN mkdir -p $SOURCE_DIR
WORKDIR $SOURCE_DIR

# update and install dependency
RUN apk update && apk upgrade
RUN apk add git

ADD package.json /tmp/package.json
RUN cd /tmp && npm install
RUN cp -a /tmp/node_modules $SOURCE_DIR

# copy the app, note .dockerignore
COPY . $SOURCE_DIR
RUN npm run build

EXPOSE 3000

ENV NUXT_HOST=0.0.0.0
ENV NUXT_PORT=3000

CMD [ "npm", "run", "dev" ]
