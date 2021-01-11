#!/bin/sh

docker build --rm --pull --tag blink-colorschemes --file ./Dockerfile .
docker run -ti --rm --volume "${PWD}"/themes:/themes blink-colorschemes
