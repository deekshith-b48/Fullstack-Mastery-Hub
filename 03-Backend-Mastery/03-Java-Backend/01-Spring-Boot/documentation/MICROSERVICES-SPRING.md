# Spring Microservices

## 📚 Overview

Spring Cloud provides tools for building microservices.

## 🔧 Service Discovery

```java
@SpringBootApplication
@EnableEurekaClient
public class UserServiceApplication {
    public static void main(String[] args) {
        SpringApplication.run(UserServiceApplication.class, args);
    }
}
```

## 🔄 Feign Client

```java
@FeignClient(name = "order-service")
public interface OrderClient {
    @GetMapping("/orders/user/{userId}")
    List<Order> getOrdersByUser(@PathVariable Long userId);
}
```

---

**Next**: Learn about [Jakarta EE](./../02-Jakarta-EE/documentation/JAKARTA-EE-FUNDAMENTALS.md)

