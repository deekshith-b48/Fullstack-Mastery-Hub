# Spring MVC Architecture

## 📚 Overview

Spring MVC follows the Model-View-Controller pattern.

## 🏗️ Architecture

```
Request → DispatcherServlet → Controller → Service → Repository → Database
                ↓
            Response ← View
```

## 🎯 Components

### Controller

```java
@Controller
@RequestMapping("/users")
public class UserController {
    
    @Autowired
    private UserService userService;
    
    @GetMapping
    public String listUsers(Model model) {
        model.addAttribute("users", userService.findAll());
        return "users/list";
    }
}
```

### Service

```java
@Service
public class UserService {
    
    @Autowired
    private UserRepository userRepository;
    
    public List<User> findAll() {
        return userRepository.findAll();
    }
}
```

### Repository

```java
@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    List<User> findByEmail(String email);
}
```

---

**Next**: Learn about [Spring Data JPA](./SPRING-DATA-JPA.md)

