# JAX-RS RESTful Services

## 📚 Overview

JAX-RS provides annotations for building RESTful web services.

## 🎯 REST Resource

```java
@Path("/users")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class UserResource {
    
    @GET
    public Response getUsers() {
        List<User> users = userService.findAll();
        return Response.ok(users).build();
    }
    
    @GET
    @Path("/{id}")
    public Response getUser(@PathParam("id") Long id) {
        User user = userService.findById(id);
        return Response.ok(user).build();
    }
    
    @POST
    public Response createUser(User user) {
        User created = userService.create(user);
        return Response.status(Response.Status.CREATED).entity(created).build();
    }
    
    @PUT
    @Path("/{id}")
    public Response updateUser(@PathParam("id") Long id, User user) {
        User updated = userService.update(id, user);
        return Response.ok(updated).build();
    }
    
    @DELETE
    @Path("/{id}")
    public Response deleteUser(@PathParam("id") Long id) {
        userService.delete(id);
        return Response.noContent().build();
    }
}
```

---

**Next**: Learn about [Persistence API](./PERSISTENCE-API.md)

