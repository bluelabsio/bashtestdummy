FROM bluelabsio/bashtestdummy:latest

USER root

#
# Build cowsay
#

RUN apt-get update -y && apt-get install -y cowsay

USER bashtestdummy

ENV PATH /usr/games:$PATH
