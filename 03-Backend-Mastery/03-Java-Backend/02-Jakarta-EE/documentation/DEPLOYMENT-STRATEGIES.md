# Jakarta EE Deployment Strategies

## 📚 Overview

Deploying Jakarta EE applications to application servers.

## 🚀 WAR Deployment

```xml
<!-- pom.xml -->
<packaging>war</packaging>

<build>
    <finalName>myapp</finalName>
</build>
```

## 📦 Application Server

### Tomcat

```bash
# Deploy WAR file
cp myapp.war $CATALINA_HOME/webapps/
```

### WildFly

```bash
# Deploy via CLI
./jboss-cli.sh --connect
deploy myapp.war
```

### GlassFish

```bash
# Deploy via asadmin
asadmin deploy myapp.war
```

---

**Next**: Learn about [Java Tools](./../03-Java-Tools/documentation/MAVEN-GRADLE.md)

