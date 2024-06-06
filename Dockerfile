# FROM openjdk:8
# EXPOSE 8761
# RUN mvn package
# ADD target/service-discovery-0.0.1-SNAPSHOT.jar service-discovery.jar
# ENTRYPOINT ["java","-jar" , "discovery.jar"]

#
# Build stage
#
FROM maven:3.6.0-jdk-11-slim AS build
COPY src /home/app/src
COPY pom.xml /home/app
RUN mvn -q -Dmaven.test.skip -f /home/app/pom.xml clean package

#
# Package stage
#
FROM openjdk:8
COPY --from=build /home/app/target/service-discovery-0.0.1-SNAPSHOT.jar /usr/local/lib/service-discovery.jar
EXPOSE 8761
ENTRYPOINT ["java","-jar","/usr/local/lib/service-discovery.jar"]