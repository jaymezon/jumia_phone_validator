### STAGE 1: Build ###
FROM maven:3.6.1-jdk-8-slim AS build
# WORKDIR /frontend-validator
# COPY pom.xml /frontend-validator
# COPY src /frontend-validator/src
RUN mvn -f pom.xml clean package

### STAGE 2: Run ###
FROM openjdk:8-alpine
# COPY --from=build /frontend-validator/target/*.jar backend-validator-0.0.1.jar
COPY --from=build /target/*.jar backend-validator-0.0.1.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","backend-validator-0.0.1.jar"]

### STAGE 2  
# FROM openjdk:8-jdk-alpine
# COPY target/validator-0.0.1.jar backend-validator-0.0.1.jar
# ENTRYPOINT ["java","-jar","/backend-validator-0.0.1.jar"]