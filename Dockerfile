FROM openjdk:8u212-jdk-alpine3.9
ADD ./spring-petclinic-2.2.0.BUILD-SNAPSHOT.jar /spring-petclinic.jar
CMD ["java", "-jar", "/spring-petclinic.jar"]
ENV MYSQL_USERNAME='petclinic'
ENV MYSQL_PASSWORD='petclinic'
ENV MYSQL_SERVER='localhost'
ENV MYSQL_SERVER_PORT='3306'
ENV MYSQL_DATABASE='petclinic'
EXPOSE 8080
MAINTAINER "satish"
