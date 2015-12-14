FROM centos:7
MAINTAINER Chris Hirsch
ENV REFRESHED_AT 2015-02-19

# Bring in any needed repos
RUN rpm -Uvh http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm

# Update to latest
RUN yum update -y

# Bring in needed packages
RUN yum -y install java-1.7.0-openjdk-devel.x86_64 rpm-build nodejs-grunt-cli npm

RUN curl -SL http://apache.mirrors.pair.com/maven/maven-3/3.1.1/binaries/apache-maven-3.1.1-bin.tar.gz | tar -zxvC /usr/local
RUN ln -s /usr/local/apache-maven-3.1.1 /usr/local/maven
RUN echo -e 'export M2_HOME=/usr/local/maven\nexport PATH=${M2_HOME}/bin:${PATH}' > /etc/profile.d/maven.sh
