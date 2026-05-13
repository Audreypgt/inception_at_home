FROM debian:bookworm
# FROM allows us to tell Docker which image to get based on, here we basically have an empty shell
# container


RUN apt-get update -y && apt-get upgrade -y
# update: updates list of available packages and their versions
# upgrade: installs newer versions
RUN apt-get install nginx -y
# this is when our container becomes a nginx container
# -y : apt will ask if we want to continue with installation, -y allows us to answer before end
# so it doesn't stop to get our input


# TLS part
# TLS : cryptographic protocol providing communication security over an internet network
RUN mkdir -p /etc/nginx/ssl
# -p allows us to create the folder ssl AND its parents
# this folder will be the place where we store our certificate and key for the secured connection
RUN apt-get install openssl -y
# OpenSSL if a tool for handling and creating SSL certificates
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key \
    -subj "/C=FR/L=Marseille/O=42/CN=apeuget.42.fr/UID=apeuget42"
# we generate an SSL certificate with a precise format (-x509), -nodes allows us to bypass the password
# asked by the command, with -out and -keyout, we give the storing places for the certificate and the key,
# at this point, the command would ask us for informations on the user for the certificate, to avoid the build
# from being interrupted, we add -subj to give them directly in the command (see IBM link for details)
RUN mkdir -p /var/run/nginx
# folder to store config files


COPY conf/nginx.conf /etc/nginx/nginx.conf 
# now for the config file, it is already existing, but we want to modify it, therefore we will create a copy of
# the config file we made, and add it in the original folder to replace it


EXPOSE 443
# To use when making the network, allows us to choose to expose a port to the other conts
# 443 is the port to access https


RUN chmod 755 /var/www/wordpress
# giving us (root user) all rights needed on our wordpress folder
RUN chown -R www-data:www-data /var/www/wordpress
# chown -R: change a file/folder's owner and group rights recursively (R) for the given folder
# chown user:group to modify both at the same time
# user and group www-data are created by debian by default because the security convention is that a web server shouldn't run on root, this role and group are then created for that, which is a role priviledge only to run web pages, and restricted from anything else on the system (eg dl softwares, read psswds...)


CMD ["nginx", "-g", "daemon off;"]
# tells nginx to run in the foreground instead of the background like a daamon (whence the daemon off) to prevent it from exiting abruptly after turning it on
