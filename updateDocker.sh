git pull && \
docker build -t isuwang-blog -f ./docker/Dockerfile . && \
docker run -p 4000:4000 --name isuwang-blog -d  isuwang-blog