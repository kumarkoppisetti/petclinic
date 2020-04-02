FROM openjdk:8u212-jdk-alpine3.9
ADD ./spring-petclinic-2.2.0.BUILD-SNAPSHOT.jar /spring-petclinic.jar
CMD ["java", "-jar", "/spring-petclinic.jar"]
EXPOSE 8080
MAINTAINER "satish"          