# 指定基础镜像，必须为第一个命令
FROM node:lts-alpine as build-stage
MAINTAINER mandy
# 工作目录
WORKDIR /app

COPY package*.json ./
RUN npm install
COPY ../ .
RUN npm run build

# production stage
FROM nginx:stable-alpine as production-stage
COPY app.conf /etc/nginx/conf.d/blog.conf
COPY --from=build-stage /app/public /usr/share/nginx/html
EXPOSE 4000
# start the blog
CMD [ "npm", "deploy" ]

