# Docker & Java

## 📚 Overview

Containerizing Java applications with Docker.

## 🐳 Dockerfile

```dockerfile
FROM openjdk:17-jdk-slim

WORKDIR /app

# Copy JAR file
COPY target/myapp.jar app.jar

# Expose port
EXPOSE 8080

# Run application
ENTRYPOINT ["java", "-jar", "app.jar"]
```

## 🐳 Multi-stage Build

```dockerfile
# Build stage
FROM maven:3.8-openjdk-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Runtime stage
FROM openjdk:17-jdk-slim
WORKDIR /app
COPY --from=build /app/target/myapp.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
```

---

**Next**: Learn about [REST APIs](./../../04-API-Development/01-REST-APIs/documentation/REST-ARCHITECTURE.md)

