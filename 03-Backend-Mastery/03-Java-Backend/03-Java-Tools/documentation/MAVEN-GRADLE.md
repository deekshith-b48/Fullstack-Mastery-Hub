# Maven & Gradle

## 📚 Overview

Maven and Gradle are build automation tools for Java projects.

## 🔧 Maven

### pom.xml

```xml
<project>
    <modelVersion>4.0.0</modelVersion>
    <groupId>com.example</groupId>
    <artifactId>myapp</artifactId>
    <version>1.0.0</version>
    
    <dependencies>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
            <version>2.7.0</version>
        </dependency>
    </dependencies>
</project>
```

### Commands

```bash
# Compile
mvn compile

# Package
mvn package

# Install
mvn install

# Clean
mvn clean

# Run
mvn spring-boot:run
```

## 📦 Gradle

### build.gradle

```gradle
plugins {
    id 'java'
    id 'org.springframework.boot' version '2.7.0'
}

dependencies {
    implementation 'org.springframework.boot:spring-boot-starter-web'
}

tasks.named('test') {
    useJUnitPlatform()
}
```

### Commands

```bash
# Build
./gradlew build

# Run
./gradlew bootRun

# Clean
./gradlew clean
```

---

**Next**: Learn about [Java Testing](./JAVA-TESTING.md)

