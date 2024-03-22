### STAGE 1: Build ###
FROM public.ecr.aws/docker/library/node:16-alpine AS build
LABEL org.opencontainers.image.description="tetris" \
      org.opencontainers.image.authors="RoxsRoss" 
WORKDIR /usr/src/app
COPY . /usr/src/app
RUN npm install && npm run build
EXPOSE 3000
USER node
CMD [ "npm" ,"start" ]

### STAGE 2: Run ###
FROM public.ecr.aws/docker/library/nginx:stable-alpine
COPY nginx/default.conf /etc/nginx/conf.d/default.conf
COPY nginx/nginx.conf /etc/nginx/nginx.conf
COPY --from=build /usr/src/app/build /usr/share/nginx/html