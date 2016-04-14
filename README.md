# Project Cars Dedicated Server

Fully-functional Project Cars server as Docker image.

The image assumes a `server.cfg` in the `/home/steam/server/config` folder, so
to customize your config, simply mount a config folder when running the
container. Make sure, you do not set the `bindIP` config, because your external
IP is not the container's IP and thus cannot be seen from within the container.

The container exposes 4 ports, three for the server to work with Steam and the
game (all UDP) and a (optional) TCP port for the server API.

To run the image, do

```
docker run -d -v $PWD/config:/home/steam/server/config \
  -p 9000:9000 \
  -p 8766:8766/udp \
  -p 27015:27015/udp \
  -p 27016:27016/udp \
  --name=project-cars-ds \
  lawitschka/project-cars-ds
```
