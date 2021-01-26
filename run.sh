#!/bin/sh

xhost + 127.0.0.1

docker run -ti --rm -e DISPLAY=host.docker.internal:0 -v $HOME/.modelio:/home/developer/.modelio:z -v $HOME/modelio:/home/developer/modelio:z --net=host --ipc=host modelio
