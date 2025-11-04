# JSP/JSF Concepts

## 📚 Overview

JSP (JavaServer Pages) and JSF (JavaServer Faces) are technologies for building web interfaces.

## 🎯 JSP Basics

```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>User List</title>
</head>
<body>
    <h1>Users</h1>
    <ul>
        <c:forEach var="user" items="${users}">
            <li>${user.name} - ${user.email}</li>
        </c:forEach>
    </ul>
</body>
</html>
```

## 🔧 JSF

```java
@ManagedBean
@RequestScoped
public class UserBean {
    private List<User> users;
    
    public List<User> getUsers() {
        return userService.findAll();
    }
}
```

---

**Next**: Learn about [Enterprise JavaBeans](./ENTERPRISE-JAVABEANS.md)

