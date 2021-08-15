# remove directories
rm -rf deploy

# creating directories
mkdir -m 777 deploy

# get into inside the directory
cd deploy

# copy the war file from local server to dockerfile
cp /var/lib/jenkins/workspace/package/target/addressbook.war . 

# creating dockerfile
touch dockerfile

# get inside of the dockerfile
echo "
FROM centos:latest

# Authorname
MAINTAINER abc

# get update the image
RUN yum update -y

# install java package
RUN yum install java-1.8* -y

#install editor
RUN yum install vim -y 

#installing nano editor
RUN yum install nano -y

# install wget package
RUN yum install wget -y

#download tomcat package
RUN wget https://mirrors.estointernet.in/apache/tomcat/tomcat-9/v9.0.52/bin/apache-tomcat-9.0.52.tar.gz

# extract the tar file
RUN tar -zxvf apache-tomcat-9.0.52.tar.gz

# deploy on tomcat 
COPY addressbook.war /apache-tomcat-9.0.52.tar.gz/webapps/bin/

#start the catalina service
CMD "/bin/./startup.sh"

# creating the port number
EXPOSE 8080" >> dockerfile

# build an image
sudo docker build -t addressbook:v1 .
