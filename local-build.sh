#!/usr/bin/env sh

docker build -t mreiche/smtprelay:latest .
docker run --rm mreiche/smtprelay:latest --help
