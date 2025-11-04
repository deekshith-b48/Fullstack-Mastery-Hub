# Servlets Mastery

## 📚 Overview

Servlets handle HTTP requests and generate responses.

## 🎯 Servlet Lifecycle

```java
@WebServlet("/users")
public class UserServlet extends HttpServlet {
    
    @Override
    public void init() throws ServletException {
        // Initialization
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Handle GET
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Handle POST
    }
    
    @Override
    public void destroy() {
        // Cleanup
    }
}
```

## 🔄 Request Handling

```java
protected void doGet(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
    String userId = request.getParameter("id");
    String pathInfo = request.getPathInfo();
    
    response.setContentType("application/json");
    response.setStatus(HttpServletResponse.SC_OK);
    
    PrintWriter out = response.getWriter();
    out.println("{\"id\": " + userId + "}");
}
```

---

**Next**: Learn about [JSP/JSF Concepts](./JSP-JSF-CONCEPTS.md)

