git pull && \
docker build -t isuwang-blog . && \
docker stop isuwang-blog && \
docker rm isuwang-blog && \
docker run -p 4000:80 --name isuwang-blog -d  isuwang-blog