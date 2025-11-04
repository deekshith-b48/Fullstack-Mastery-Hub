# Java Security Best Practices

## 📚 Overview

Security best practices for Java applications.

## 🛡️ Best Practices

### 1. Input Validation

```java
public void validateEmail(String email) {
    if (email == null || !email.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
        throw new IllegalArgumentException("Invalid email");
    }
}
```

### 2. SQL Injection Prevention

```java
// Use parameterized queries
PreparedStatement stmt = conn.prepareStatement(
    "SELECT * FROM users WHERE email = ?"
);
stmt.setString(1, email);
```

### 3. Secrets Management

```java
// Use environment variables or secret management services
String apiKey = System.getenv("API_KEY");
```

---

**Next**: Learn about [Docker Java](./DOCKER-JAVA.md)

