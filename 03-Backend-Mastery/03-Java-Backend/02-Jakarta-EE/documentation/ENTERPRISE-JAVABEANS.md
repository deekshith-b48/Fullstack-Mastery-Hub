# Enterprise JavaBeans

## 📚 Overview

EJB provides server-side business logic components.

## 🎯 Session Beans

```java
@Stateless
public class UserService {
    
    @PersistenceContext
    private EntityManager em;
    
    public User createUser(User user) {
        em.persist(user);
        return user;
    }
    
    public User findById(Long id) {
        return em.find(User.class, id);
    }
}
```

## 🔄 Message-Driven Beans

```java
@MessageDriven
public class OrderProcessor implements MessageListener {
    
    @Override
    public void onMessage(Message message) {
        // Process message
    }
}
```

---

**Next**: Learn about [JAX-RS RESTful](./JAX-RS-RESTFUL.md)

