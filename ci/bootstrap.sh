#!/usr/bin/env bash


# set plugin directory
SONAR_PLUGIN_DIR=/opt/ci-sync/sonarqube_home/extensions/plugins
mkdir -p ${SONAR_PLUGIN_DIR}

# git
GIT_PLUGIN_VERSION=1.1
curl -sLo $SONAR_PLUGIN_DIR/sonar-scm-git-plugin-${GIT_PLUGIN_VERSION}.jar \
	http://downloads.sonarsource.com/plugins/org/codehaus/sonar-plugins/sonar-scm-git-plugin/${GIT_PLUGIN_VERSION}/sonar-scm-git-plugin-${GIT_PLUGIN_VERSION}.jar

# java	
JAVA_PLUGIN_VERSION=3.9
curl -sLo $SONAR_PLUGIN_DIR/sonar-java-plugin-${JAVA_PLUGIN_VERSION}.jar \
	https://sonarsource.bintray.com/Distribution/sonar-java-plugin/sonar-java-plugin-${JAVA_PLUGIN_VERSION}.jar

JPROPERTIES_PLUGIN_VERSION=1.5
curl -sLo $SONAR_PLUGIN_DIR/sonar-jproperties-plugin-${JPROPERTIES_PLUGIN_VERSION}.jar \
	https://github.com/racodond/sonar-jproperties-plugin/releases/download/${JPROPERTIES_PLUGIN_VERSION}/sonar-jproperties-plugin-${JPROPERTIES_PLUGIN_VERSION}.jar

# web
CSS_PLUGIN_VERSION=1.6
curl -sLo $SONAR_PLUGIN_DIR/sonar-css-plugin.jar \
	https://github.com/SonarQubeCommunity/sonar-css/releases/download/${CSS_PLUGIN_VERSION}/sonar-css-plugin.jar

JAVASCRIPT_PLUGIN_VERSION=2.10
curl -sLo $SONAR_PLUGIN_DIR/sonar-javascript-plugin-${JAVASCRIPT_PLUGIN_VERSION}.jar \
	https://sonarsource.bintray.com/Distribution/sonar-javascript-plugin/sonar-javascript-plugin-${JAVASCRIPT_PLUGIN_VERSION}.jar

WEB_PLUGIN_VERSION=2.4
curl -sLo $SONAR_PLUGIN_DIR/sonar-web-plugin-${ENV_WEB_PLUGIN_VERSION}.jar \
	https://sonarsource.bintray.com/Distribution/sonar-web-plugin/sonar-web-plugin-${ENV_WEB_PLUGIN_VERSION}.jar

# formats	
JSON_PLUGIN_VERSION=1.4
curl -sLo $SONAR_PLUGIN_DIR/sonar-json-plugin-${JSON_PLUGIN_VERSION}.jar \
	https://github.com/racodond/sonar-json-plugin/releases/download/${JSON_PLUGIN_VERSION}/sonar-json-plugin-${JSON_PLUGIN_VERSION}.jar

XML_PLUGIN_VERSION=1.4
curl -sLo $SONAR_PLUGIN_DIR/sonar-xml-plugin-${XML_PLUGIN_VERSION}.jar \
	http://sonarsource.bintray.com/Distribution/xml/sonar-xml-plugin-${XML_PLUGIN_VERSION}.jar

# misc 
SONARGRAPH_PLUGIN_VERSION=3.4.2
curl -sLo $SONAR_PLUGIN_DIR/sonar-sonargraph-plugin-${SONARGRAPH_PLUGIN_VERSION}.jar \
	http://downloads.sonarsource.com/plugins/org/codehaus/sonar-plugins/sonar-sonargraph-plugin/${SONARGRAPH_PLUGIN_VERSION}/sonar-sonargraph-plugin-${SONARGRAPH_PLUGIN_VERSION}.jar
	
