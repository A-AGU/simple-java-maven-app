# First stage: complete build environment
# FROM maven:3.6.1-jdk-8-alpine AS builder
FROM registry.cn-hangzhou.aliyuncs.com/akulib/maven:3.8.6-jdk-8 AS builder

# add pom.xml and source code
ADD ./pom.xml pom.xml
ADD ./src src/

# package jar
RUN mvn clean package
# Second stage: minimal runtime environment
From registry.cn-hangzhou.aliyuncs.com/akulib/openjdk:8-jdk-alpine3.9
# copy jar from the first stage
COPY --from=builder target/my-app-1.0-SNAPSHOT.jar my-app-1.0-SNAPSHOT.jar

EXPOSE 8080

CMD ["java", "-jar", "my-app-1.0-SNAPSHOT.jar"]
