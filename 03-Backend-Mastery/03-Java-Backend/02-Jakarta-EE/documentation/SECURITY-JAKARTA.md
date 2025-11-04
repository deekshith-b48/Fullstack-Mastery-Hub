# Jakarta Security

## 📚 Overview

Jakarta Security provides authentication and authorization.

## 🔐 Security Configuration

```java
@ApplicationScoped
public class SecurityConfig {
    
    @Inject
    private UserService userService;
    
    public boolean authenticate(String username, String password) {
        User user = userService.findByUsername(username);
        return user != null && user.getPassword().equals(hash(password));
    }
}
```

## 🔒 Role-Based Access

```java
@RolesAllowed("ADMIN")
@Path("/admin")
public class AdminResource {
    
    @GET
    public Response getAdminData() {
        return Response.ok("Admin data").build();
    }
}
```

---

**Next**: Learn about [Deployment Strategies](./DEPLOYMENT-STRATEGIES.md)

