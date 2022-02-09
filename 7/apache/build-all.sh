#!/bin/bash
# a convenience script to build all the 7/apache prosimulium containers locally
# by overriding the default ARG REPOSITORY_FROM=blackflysolutions/
docker build --build-arg REPOSITORY_FROM='' drupal/ -t prosimulium:7-apache
docker build --build-arg REPOSITORY_FROM='' admin/ -t prosimulium:7-apache-admin
