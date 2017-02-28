# TODO: Update back to latest
FROM docker.int.bluelabs.io/bluelabs/bashtestdummy:initial

#
# Build cowsay
#

RUN apt-get update -y && apt-get install -y cowsay
ENV PATH /usr/games:$PATH