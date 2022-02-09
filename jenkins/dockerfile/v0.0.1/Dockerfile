FROM docker.io/jenkins/jenkins:2.321-jdk11

USER root
WORKDIR /tmp/cjenm
#/*********************
#module change uid gid
#*********************/
RUN 	sed -i 's/jenkins:x:1000:jenkins/jenkins:x:1001:jenkins/' /etc/group && \
	sed -i 's/jenkins:x:1000:1000/jenkins:x:1001:1001/' /etc/passwd
#/*********************
#module change uid gid
#*********************/

USER jenkins
WORKDIR /var/jenkins_home

