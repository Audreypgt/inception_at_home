FROM debian:bookworm

RUN apt-get update -y 
RUN apt-get install -y nginx openssl
RUN rm -rf /var/lib/apt/lists/*


# TLS part
RUN mkdir -p /etc/nginx/ssl
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key \
-subj "/C=FR/L=Marseille/O=42/CN=apeuget.42.fr/UID=apeuget42"


# nginx folders creation
RUN chown -R www-data:www-data /etc/nginx/
RUN chmod 755 /etc/nginx/
RUN mkdir -p /var/run/nginx

# COPY conf/nginx.conf /etc/nginx/nginx.conf 
# now for the config file, it is already existing, but we want to modify it, therefore we will create a copy of
# the config file we made, and add it in the original folder to replace it
# replace in the docker compose file in volumes

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]