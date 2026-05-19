TODO :
- configure PHP-FPM ?
- run everything and after php is installed, modify config file
    - add lines: clear_env=no and listen=wordpress:9000
    - copy it from our files to the container's files just like for nginx.conf
- understand better how to run an image, start/stop a cont, and how to not get the latest version of nginx automatically from my dockerfile
- makefile
- dockerignores ?
- make docker secrets work


- refaire VM comme avant mais en cochant gnome quand on coche ce quon isntalle pour avoir interface graphique ou lier vm et local host
Accessing wordpress website from VM's local host:
Docker container must publish its port to the VM's network interface, and your local machine must be able to reach the VM's IP address
- ensure the container port (usually 80) is mapped to the VM's IP (0.0.0.0) rather than just localhost (127.0.0.1) (search files with ip adress 127 here). The command should look like this: `docker run -p 0.0.0.0:8080:80` Here, 8080 is the port on the VM, and 80 is the port inside the container. If you didn't specify 0.0.0.0, Docker defaults to 127.0.0.1, which blocks external access
- identify the IP address of he VM (`hostname -I`)
- might need to allow traffic on ufw on the mapped port: `sudo ufw allow 8080/tcp`
Once the port is open and mapped, simply open Firefox or Chrome on your local machine and type http://<VM_IP_ADDRESS>:<Mapped_Port> (e.g., http://192.168.1.50:8080). You should see your WordPress installation screen.







sudo docker compose -f docker-compose.yaml up -d --build
