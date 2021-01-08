#!/bin/sh

docker build --rm --pull --tag blink-colorschemes --file ./Dockerfile .
docker run --rm --detach --name blink-colorschemes blink-colorschemes
docker cp blink-colorschemes:/themes .
docker stop blink-colorschemes
