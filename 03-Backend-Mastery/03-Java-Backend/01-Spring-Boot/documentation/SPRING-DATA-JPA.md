# Spring Data JPA

## 📚 Overview

Spring Data JPA simplifies database access.

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

## 🔍 Repository

```java
@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    List<User> findByEmail(String email);
    List<User> findByNameContaining(String name);
    Optional<User> findByEmailAndName(String email, String name);
}
```

## 📝 Query Methods

```java
@Query("SELECT u FROM User u WHERE u.age > :age")
List<User> findUsersOlderThan(@Param("age") int age);
```

---

**Next**: Learn about [Spring Security](./SPRING-SECURITY.md)

