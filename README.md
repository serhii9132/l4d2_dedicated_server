# docker_l4d2_dedicated_server

Docker container for Left 4 Dead 2 dedicated server.

Based on the ubuntu:noble-20231221 image.

# Usage
```
docker pull serhiiartiukh5465/l4d2_server:latest

docker run --name l4d2_server -p 27015:27015 -p 27015:27015/udp -v l4d2_server_data:/home/steam_user/files_server/ serhiiartiukh5465/l4d2_server:latest
```