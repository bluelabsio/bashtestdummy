#!/bin/bash -e

( cd tests && docker build -t local-test-framework . )
docker run -v "$(pwd):/usr/src/app" \
       -t \
       --rm \
       local-test-framework
