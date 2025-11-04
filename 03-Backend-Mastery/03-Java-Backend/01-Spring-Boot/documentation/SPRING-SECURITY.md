# Spring Security

## 📚 Overview

Spring Security provides authentication and authorization.

## 🔐 Configuration

```java
@Configuration
@EnableWebSecurity
public class SecurityConfig {
    
    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
            .authorizeHttpRequests(auth -> auth
                .requestMatchers("/public/**").permitAll()
                .anyRequest().authenticated()
            )
            .httpBasic();
        return http.build();
    }
}
```

## 🔑 JWT Authentication

```java
@Component
public class JwtTokenProvider {
    
    public String generateToken(UserDetails userDetails) {
        // Generate JWT token
    }
    
    public boolean validateToken(String token) {
        // Validate token
    }
}
```

---

**Next**: Learn about [REST Controllers](./REST-CONTROLLERS.md)

