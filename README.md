# bundled-portable-ci
This project is a simple JavaEE project, which comes with a bundled, portable continuous integration environment. 

## Goals for this project
- description of the CI environment as code (that it can be created automatically)
- bundled together with the actual project (to have everything in one place)
- portability (that it can run in different environments)
- execution of a CI pipeline that includes the following steps
    - compilation of the project
    - create a disposable test environment including database and application server
    - execute tests
        - unit tests
        - integration tests
        - system tests
    - code quality analysis
    - report including code quality, test results and code coverage

Basically I used this project to get myself familiar with different technologies. 
Since it was not so easy to get everything working together, I share this project here and hope it can help someone. Suggestions and improvements are welcome!

## Sample project
The sample project is a very simple JavaEE project, which exposes greeting messages from the database via REST (JAX-RS). 

## Technology stack
- [Vagrant](https://www.vagrantup.com) (portability of the CI)
- [Docker](https://www.docker.com) (disposable testbed containers)
- [Jenkins](https://jenkins-ci.org) (continuous integration environment)
- [Maven](https://maven.apache.org) (build and dependency management)
- [JaCoCo](http://eclemma.org/jacoco) (record code coverage for unit and integration tests)
- [SonarQube](http://www.sonarqube.org) (code quality analysis and report)

## Testbed
- [PostgreSQL](http://www.postgresql.org)
- [Payara](http://www.payara.fish)

## Usage
Install [Vagrant](http://vagrantup.com) / [VirtualBox](https://www.virtualbox.org) with the following PlugIns

- ```vagrant plugin install vagrant-vbguest```
- ```vagrant plugin install vagrant-docker-compose```

After that execute ```vagrant up``` inside the ```ci``` directory, which will bring up all services. 

- Jenkins: [http://localhost:18080](http://localhost:18080)
- SonarQube: [http://localhost:19000](http://localhost:19000)

When Jenkins is ready the GIT credentials must be set for the existing job. That's it! 
Hit 'Build Project' and view the results at SonarQube.

## Notes
- During installation the scripts automatically agree to the [license agreement](http://www.oracle.com/technetwork/java/javase/terms/license/index.html) for Oracle JDK. Do not use this project, if you do not agree with this license agreement.

## Future extensions
- Add stress tests with [Gatling](http://gatling.io)
- Support parallel builds in Jenkins
