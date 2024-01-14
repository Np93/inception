FROM alpine:3.13

RUN	apk update && apk upgrade && apk add --no-cache \
        nginx \
        openssl

# nginx SSL
RUN mkdir /etc/nginx/ssl
RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
        -out /etc/nginx/ssl/nhirzel.42.fr.crt \
        -keyout /etc/nginx/ssl/nhirzel.42.fr.key \
        -subj "/C=CH/ST=VD/L=Lausanne/O=42/OU=42/CN=nhirzel.42.fr/UID=nhirzel"
        #-subj "/C=CH/ST=VD/L=Lausanne/O=42 School/OU=nhirzel/CN=nhirzel/"

# nginx config
RUN mkdir -p /run/nginx
COPY conf/nginx.conf /etc/nginx/conf.d/default.conf

#COPY conf/nginx.conf /etc/nginx/nginx.conf

EXPOSE 443

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
