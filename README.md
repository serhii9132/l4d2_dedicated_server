# l4d2_dedicated_server

Docker image for Left 4 Dead 2 Dedicated Server [(DockerHub link)](https://hub.docker.com/r/serhiiartiukh5465/l4d2_dedicated_server).

Base Docker image - [ubuntu:25.04](https://hub.docker.com/layers/library/ubuntu/25.04/images/sha256-3f0fd8560d144762a3b5a670e70bde00714347386eb7213eb651edc41aa6f241).

#  How to start
## **Deploying on Docker**
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

### Example additional arguments
```
docker run --name l4d2_server -t -p 27015:27015 -v l4d2_server_data:/home/steam_user/files_server/ serhiiartiukh5465/l4d2_server +map c1m4_atrium +maxplayers 16 

docker run --name l4d2_server -t -p 27015:27015 -v l4d2_server_data:/home/steam_user/files_server/ serhiiartiukh5465/l4d2_server -ip 0.0.0.0

```

### Volume
All server files will be located in the volume **l4d2_server_data**. Approximate size of the data when unpacked is 9 GB.

## **Deploying on K8S cluster**

Deployment:

```
namespace: l4d2-server-namespace
labels:
    app: l4d2-server
replicas: 1
DNS nameservers: 8.8.8.8
```

Service:
```
type: LoadBalancer
protocol: TCP/UDP
port: 27015
```

PVC:
```
resources:
    requests:
        storage: 12Gi
accessModes:
    - ReadWriteOnce
```

# License
MIT