To build the Docker container 
1. Clone the repo
2. Clone the https://github.com/pkp/pkppln repo in a folder named `pkppln` inside the 1. repo
3. Execute `docker-compose up --build`

To stop and erase the containers 
1. Execute `docker-compose down`

To have access to the php-container 
1. Execute `docker exec -it php-container /bin/bash`

To have local access to the mysql-container 
1. On your MySQL client application create a new connection with
Hostname: localhost
Port: 3307
Username: pn
Password: abc123
Default Schema: pn