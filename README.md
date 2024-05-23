# l4d2_dedicated_server

Docker image for Left 4 Dead 2 Dedicated Server [(DockerHub link)](https://hub.docker.com/r/serhiiartiukh5465/l4d2_dedicated_server).

Base Docker image - [ubuntu:24.04](https://hub.docker.com/layers/library/ubuntu/24.04/images/sha256-31e02f893eaf7729befc0e21920e63b968bffe76760943a6f56fa1c7f3abb055?context=explore).

#  How to start
#### Pull from DockerHub:
```
docker pull serhiiartiukh5465/l4d2_dedicated_server

docker run --name l4d2_server -t -p 27015:27015 -v l4d2_server_data:/home/steam_user/files_server/ serhiiartiukh5465/l4d2_dedicated_server
```
#### or build the image locally:
```
docker volume create l4d2_server_data

docker compose build && docker compose up
```

The default server launch parameters.: 
-console -maxplayers 8 +map c1m1_hotel +sv_lan 0. 

The server port 27015 is constant.

### Example additional arguments
```
docker run --name l4d2_server -t -p 27015:27015 -v l4d2_server_data:/home/steam_user/files_server/ serhiiartiukh5465/l4d2_server +map c1m4_atrium +maxplayers 16 

docker run --name l4d2_server -t -p 27015:27015 -v l4d2_server_data:/home/steam_user/files_server/ serhiiartiukh5465/l4d2_server -ip 0.0.0.0

docker run --name l4d2_server -t -p 27015:27015 -v l4d2_server_data:/home/steam_user/files_server/ serhiiartiukh5465/l4d2_server +sv_lan 1 

```

## Volumes
All server files will be located in the volume **l4d2_server_data**. Approximate size of the data when unpacked is 9 GB.

# License
MIT