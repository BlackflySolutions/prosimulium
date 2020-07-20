#!/bin/bash
# a convenience script to build all the prosimulium containers locally
# by overriding the default ARG REPOSITORY_FROM=blackflysolutions/
docker build --build-arg REPOSITORY_FROM='' drupal/ -t prosimulium:8-apache
docker build --build-arg REPOSITORY_FROM='' admin/ -t prosimulium:8-apache-admin
#docker build --build-arg REPOSITORY_FROM='' editor/ -t prosimulium:8-apache-editor
