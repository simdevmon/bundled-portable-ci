#!/usr/bin/env bash

# remove Sonarqube cache from Jenkins
sudo rm -rf /opt/ci-sync/jenkins_home/.sonar/cache/*
sudo rm -rf /opt/ci-sync/jenkins_home/.sonar/ws_cache/*

# build docker images
cd /opt/ci-sync/dockerfiles

sudo docker-compose stop
sudo docker-compose rm -f

sudo docker-compose build
sudo docker-compose up -d

# make socker.sock accessible
sudo chmod 777 /var/run/docker.sock
