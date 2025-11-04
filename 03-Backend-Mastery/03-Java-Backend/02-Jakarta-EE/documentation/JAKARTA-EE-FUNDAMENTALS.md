# Jakarta EE Fundamentals

## 📚 Overview

Jakarta EE (formerly Java EE) is a platform for enterprise Java applications.

## 🏗️ Architecture

Jakarta EE provides:
- **Servlets**: HTTP request handling
- **JSP/JSF**: Web presentation
- **EJB**: Business logic
- **JPA**: Persistence
- **JAX-RS**: RESTful services

## 🎯 Servlet

```java
@WebServlet("/users")
public class UserServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Handle GET request
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        out.println("{\"users\": []}");
    }
}
```

---

**Next**: Learn about [Servlets Mastery](./SERVLETS-MASTERY.md)

