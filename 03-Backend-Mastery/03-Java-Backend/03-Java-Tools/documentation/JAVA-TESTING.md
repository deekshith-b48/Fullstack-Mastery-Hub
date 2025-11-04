# Java Testing

## 📚 Overview

Testing Java applications with JUnit and Mockito.

## 🧪 JUnit

```java
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

class UserServiceTest {
    
    @Test
    void testFindById() {
        UserService service = new UserService();
        User user = service.findById(1L);
        assertNotNull(user);
        assertEquals(1L, user.getId());
    }
}
```

## 🎯 Mockito

```java
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

@ExtendWith(MockitoExtension.class)
class UserServiceTest {
    
    @Mock
    private UserRepository repository;
    
    @Test
    void testFindById() {
        when(repository.findById(1L)).thenReturn(new User());
        UserService service = new UserService(repository);
        User user = service.findById(1L);
        assertNotNull(user);
    }
}
```

---

**Next**: Learn about [Deployment Java](./DEPLOYMENT-JAVA.md)

