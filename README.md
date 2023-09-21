## To build the Docker container 
1. Clone the repo
2. Clone the https://github.com/pkp/pkppln repo in a folder named `pkppln` inside the 1. repo
3. Execute `docker-compose up --build`

## To stop and erase the containers 
Execute `docker-compose down`

## To have command-line access to the php-container 
Execute `docker exec -it php-container /bin/bash`

## To have local access to the staging server
http://localhost:8087/pn/public

## To have local access to the mysql-container DB
On your MySQL client application create a new connection with
```
Hostname: localhost
Port: 3307
Username: pn
Password: abc123
Default Schema: pn
```
