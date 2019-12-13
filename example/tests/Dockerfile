FROM bluelabsio/bashtestdummy:latest

#
# Build cowsay
#

RUN apt-get update -y && apt-get install -y cowsay
ENV PATH /usr/games:$PATH