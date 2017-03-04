FROM ubuntu:latest

#
# Copy in Rakefile for ratcheting
#

RUN apt-get update -y && apt-get install -y kcov ruby

RUN mkdir -p /usr/bashtestdummy
COPY . /usr/bashtestdummy

#
# Prep area for source code to go
#

RUN mkdir -p /usr/src/app/tests
WORKDIR /usr/src/app

VOLUME /usr/src/app

ENTRYPOINT ["/usr/bin/rake", "-f", "/usr/bashtestdummy/Rakefile", "test"]
