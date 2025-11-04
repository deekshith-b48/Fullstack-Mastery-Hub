# Spring Boot Fundamentals

## 📚 Overview

Spring Boot simplifies Spring application development with auto-configuration.

## 🚀 Getting Started

### Project Setup

```bash
# Using Spring Initializr
# https://start.spring.io/

# Or Maven
mvn archetype:generate -DgroupId=com.example -DartifactId=myapp
```

### Dependencies (pom.xml)

```xml
<dependencies>
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-web</artifactId>
    </dependency>
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-data-jpa</artifactId>
    </dependency>
</dependencies>
```

## 🎯 Main Application

```java
@SpringBootApplication
public class Application {
    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }
}
```

## 🛣️ REST Controller

```java
@RestController
@RequestMapping("/api/users")
public class UserController {
    
    @GetMapping
    public List<User> getUsers() {
        return userService.findAll();
    }
    
    @GetMapping("/{id}")
    public User getUser(@PathVariable Long id) {
        return userService.findById(id);
    }
    
    @PostMapping
    public User createUser(@RequestBody User user) {
        return userService.save(user);
    }
}
```

## ⚙️ Application Properties

```properties
# application.properties
server.port=8080
spring.datasource.url=jdbc:mysql://localhost:3306/mydb
spring.datasource.username=root
spring.datasource.password=password
```

---

**Next**: Learn about [Spring MVC Architecture](./SPRING-MVC-ARCHITECTURE.md)

