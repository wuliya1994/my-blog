# 指定基础镜像，必须为第一个命令
FROM node:lts-alpine as build-stage
MAINTAINER Mandy
# 工作目录
WORKDIR /app
COPY package*.json ./
RUN npm --registry=https://registry.npm.taobao.org install hexo-cli -g && npm install
COPY . .
RUN hexo clean && hexo g

# production stage
FROM nginx:stable-alpine as production-stage
COPY ./docker/app.conf /etc/nginx/conf.d/blog.conf
COPY --from=build-stage /app/public /usr/share/nginx/html
EXPOSE 4000
# start the blog
CMD ["nginx", "-g", "daemon off;"]


