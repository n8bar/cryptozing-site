# Build the static site, then serve it with nginx. This container is what the
# production box runs behind its front proxy (MS20.2 §3.3); the published
# self-host recipe ships without it.
FROM node:20-alpine AS build
WORKDIR /src
COPY package.json package-lock.json ./
RUN npm ci
COPY . .
# .eleventy.js keys on CI to output _site/ (Actions sets this; docker doesn't).
ENV CI=true
RUN npx @11ty/eleventy

FROM nginx:1.27-alpine
COPY --from=build /src/_site /usr/share/nginx/html
COPY docker/nginx-default.conf /etc/nginx/conf.d/default.conf
