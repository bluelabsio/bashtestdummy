FROM docker.int.bluelabs.io/bluelabs/bashtestdummy:latest

#
# Build cowsay
#

RUN apt-get update -y && apt-get install -y cowsay
ENV PATH /usr/games:$PATH