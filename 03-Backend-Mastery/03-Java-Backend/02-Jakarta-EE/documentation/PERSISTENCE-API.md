# Jakarta Persistence API

## 📚 Overview

JPA provides object-relational mapping for Java applications.

## 🎯 Entity

```java
@Entity
@Table(name = "users")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(nullable = false)
    private String name;
    
    @Column(unique = true)
    private String email;
    
    // Getters and setters
}
```

## 🔍 EntityManager

```java
@PersistenceContext
private EntityManager em;

public User findById(Long id) {
    return em.find(User.class, id);
}

public List<User> findAll() {
    TypedQuery<User> query = em.createQuery("SELECT u FROM User u", User.class);
    return query.getResultList();
}

public User save(User user) {
    em.persist(user);
    return user;
}
```

---

**Next**: Learn about [Security Jakarta](./SECURITY-JAKARTA.md)

