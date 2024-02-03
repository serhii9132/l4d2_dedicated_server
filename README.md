# docker_l4d2_dedicated_server

Docker [image](https://hub.docker.com/r/serhiiartiukh5465/l4d2_dedicated_server) for Left 4 Dead 2 Dedicated Server.

Base Docker image - [ubuntu:noble-20231221](https://hub.docker.com/layers/library/ubuntu/noble-20231221/images/sha256-145bacc9db29ff9c9c021284e5b7b22f1193fc38556c578250c926cf3c883a13?context=explore).

#  How to start
### Default launch options
```
docker run --name l4d2_server -t -p 27015:27015 -p 27015:27015/udp -v l4d2_server_data:/home/steam_user/files_server/ serhiiartiukh5465/l4d2_server
```
### or Docker Compose
```
docker compose up -d
```
## 
This commands will start the server with the specified parameters: 
**./srcds_run -game left4dead2 -port 27015 -norestart -console -maxplayers 8 +map c1m1_hotel +sv_lan 0**. The server port is constant.

### Example additional arguments
```
docker run --name l4d2_server -t -p 27015:27015 -p 27015:27015/udp -v l4d2_server_data:/home/steam_user/files_server/ serhiiartiukh5465/l4d2_server +map c1m4_atrium +maxplayers 16 

docker run --name l4d2_server -t -p 27015:27015 -p 27015:27015/udp -v l4d2_server_data:/home/steam_user/files_server/ serhiiartiukh5465/l4d2_server -ip 0.0.0.0

docker run --name l4d2_server -t -p 27015:27015 -p 27015:27015/udp -v l4d2_server_data:/home/steam_user/files_server/ serhiiartiukh5465/l4d2_server +sv_lan 1 

```

## Volumes
All server files will be located in the volume **l4d2_server_data**. Approximate size of the data when unpacked is 9 GB.

# License
MIT