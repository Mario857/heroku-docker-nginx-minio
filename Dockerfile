FROM nginx:1.20.1-alpine

COPY default.conf.template /etc/nginx/conf.d/default.conf.template
COPY nginx.conf /etc/nginx/nginx.conf
COPY static-html /usr/share/nginx/html
RUN apk update
RUN apk add ca-certificates wget
RUN update-ca-certificates

RUN wget https://dl.min.io/server/minio/release/linux-amd64/minio
RUN chmod +x minio

CMD  ./minio server /data & echo 'done' && /bin/sh -c "envsubst '\$PORT' < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf" && nginx -g 'daemon off;' ;




