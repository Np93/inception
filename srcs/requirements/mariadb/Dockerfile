FROM alpine:3.14

RUN	apk update && apk upgrade && apk add --no-cache \
        mariadb \
        mariadb-client
        
COPY tools/configure.sh /tmp/configure.sh

RUN chown -R mysql:mysql /var/lib/mysql

EXPOSE 3306

CMD ["sh", "/tmp/configure.sh"]