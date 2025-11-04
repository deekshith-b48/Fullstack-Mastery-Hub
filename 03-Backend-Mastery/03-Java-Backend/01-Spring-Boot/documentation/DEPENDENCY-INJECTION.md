# Spring Dependency Injection

## 📚 Overview

Spring's dependency injection manages object creation and dependencies.

## 🎯 Constructor Injection

```java
@Service
public class UserService {
    
    private final UserRepository userRepository;
    
    public UserService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }
}
```

## 🔧 Field Injection

```java
@Service
public class UserService {
    
    @Autowired
    private UserRepository userRepository;
}
```

## 📝 Setter Injection

```java
@Service
public class UserService {
    
    private UserRepository userRepository;
    
    @Autowired
    public void setUserRepository(UserRepository userRepository) {
        this.userRepository = userRepository;
    }
}
```

---

**Next**: Learn about [Spring Testing](./SPRING-TESTING.md)

