#!/bin/sh
cd ${0%/*}

# stop and remove testbed
docker stop dockerfiles_db-integration-test_1 && docker rm dockerfiles_db-integration-test_1
docker stop dockerfiles_appserver-system-test_1 && docker rm dockerfiles_appserver-system-test_1
docker stop dockerfiles_db-system-test_1 && docker rm dockerfiles_db-system-test_1

# start testbed 
docker-compose up -d --no-recreate 

echo "Waiting for testbed..."
while ! nc -z dockerfiles_db-integration-test_1 3306; do   
  sleep 1.0
done
while ! nc -z appserver-system-test 4848; do   
  sleep 1.0
done
echo "...testbed is ready!"

# deploy application
curl --user admin:glassfish -s -S  -H "Accept: application/json" -X POST -H "X-Requested-By: dummy" -k -F id=@${WORKSPACE}/greeting/target/greeting.war -F force=true https://appserver-system-test:4848/management/domain/applications/application
