#!/bin/bash
# a convenience script to build all the prosimulium images locally
# by overriding the default ARG REPOSITORY_FROM=blackflysolutions/
docker build --build-arg REPOSITORY_FROM='' drupal/ -t prosimulium:9-apache
docker build --build-arg REPOSITORY_FROM='' admin/ -t prosimulium:9-apache-admin
