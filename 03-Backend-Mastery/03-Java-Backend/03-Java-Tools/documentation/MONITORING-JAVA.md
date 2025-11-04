# Java Monitoring

## 📚 Overview

Monitoring Java applications for performance and health.

## 📊 Actuator (Spring Boot)

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-actuator</artifactId>
</dependency>
```

```properties
# application.properties
management.endpoints.web.exposure.include=health,info,metrics
management.endpoint.health.show-details=always
```

## 🎯 Health Checks

```java
@Component
public class CustomHealthIndicator implements HealthIndicator {
    
    @Override
    public Health health() {
        if (checkHealth()) {
            return Health.up().build();
        }
        return Health.down().build();
    }
}
```

---

**Next**: Learn about [Performance Tuning](./PERFORMANCE-TUNING.md)

