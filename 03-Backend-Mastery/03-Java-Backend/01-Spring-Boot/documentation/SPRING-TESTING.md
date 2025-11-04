# Spring Testing

## 📚 Overview

Spring provides testing support for applications.

## 🧪 Unit Tests

```java
@SpringBootTest
class UserServiceTest {
    
    @Autowired
    private UserService userService;
    
    @Test
    void testFindAll() {
        List<User> users = userService.findAll();
        assertNotNull(users);
    }
}
```

## 🌐 Integration Tests

```java
@SpringBootTest
@AutoConfigureMockMvc
class UserControllerTest {
    
    @Autowired
    private MockMvc mockMvc;
    
    @Test
    void testGetUsers() throws Exception {
        mockMvc.perform(get("/api/users"))
            .andExpect(status().isOk());
    }
}
```

---

**Next**: Learn about [Microservices](./MICROSERVICES-SPRING.md)

