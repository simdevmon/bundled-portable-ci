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

# configure sonarqube
while ! curl -s http://localhost:9000/api/system/status; do   
  echo "Waiting for SonarQube API..."
  sleep 5.0
done

SQ_ENDPOINT=http://localhost:9000/api
SQ_JAVA_PROFILE=`curl -s ${SQ_ENDPOINT}/qualityprofiles/search?language=java | python -mjson.tool | grep java-sonar | tr -d ',"' | sed 's/^.*java/java/'`
curl -u admin:admin -H "Content-Type: application/json" -X POST -d '{"profile_key":"'${SQ_JAVA_PROFILE}'","rule_key":"Sonargraph:sonargraph.architecture"}' ${SQ_ENDPOINT}/qualityprofiles/activate_rule
curl -u admin:admin -H "Content-Type: application/json" -X POST -d '{"profile_key":"'${SQ_JAVA_PROFILE}'","rule_key":"Sonargraph:sonargraph.cyclegroup"}' ${SQ_ENDPOINT}/qualityprofiles/activate_rule
curl -u admin:admin -H "Content-Type: application/json" -X POST -d '{"profile_key":"'${SQ_JAVA_PROFILE}'","rule_key":"Sonargraph:sonargraph.duplicate"}' ${SQ_ENDPOINT}/qualityprofiles/activate_rule
curl -u admin:admin -H "Content-Type: application/json" -X POST -d '{"profile_key":"'${SQ_JAVA_PROFILE}'","rule_key":"Sonargraph:sonargraph.open_task"}' ${SQ_ENDPOINT}/qualityprofiles/activate_rule
curl -u admin:admin -H "Content-Type: application/json" -X POST -d '{"profile_key":"'${SQ_JAVA_PROFILE}'","rule_key":"Sonargraph:sonargraph.threshold"}' ${SQ_ENDPOINT}/qualityprofiles/activate_rule
curl -u admin:admin -H "Content-Type: application/json" -X POST -d '{"profile_key":"'${SQ_JAVA_PROFILE}'","rule_key":"Sonargraph:sonargraph.workspace"}' ${SQ_ENDPOINT}/qualityprofiles/activate_rule
