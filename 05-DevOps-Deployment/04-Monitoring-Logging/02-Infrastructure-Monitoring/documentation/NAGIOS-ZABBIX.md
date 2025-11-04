# Nagios & Zabbix

## 📚 Overview

Nagios and Zabbix are popular open-source monitoring solutions. They provide comprehensive infrastructure monitoring capabilities with alerting and notification features.

## 🎯 Nagios

### What is Nagios?

Nagios is a powerful monitoring system that enables organizations to identify and resolve IT infrastructure problems before they affect critical business processes.

### Key Features

- **Host Monitoring**: Monitor servers and devices
- **Service Monitoring**: Monitor services
- **Alerting**: Notifications for issues
- **Plugins**: Extensible plugin architecture
- **Web Interface**: Web-based management

### Installation

```bash
# Install Nagios Core
sudo apt-get update
sudo apt-get install nagios4 nagios-plugins-contrib

# Configure Nagios
# /etc/nagios4/nagios.cfg
```

### Configuration

```bash
# Host configuration
# /etc/nagios4/conf.d/hosts.cfg
define host {
    use                     linux-server
    host_name               server1
    alias                   Server 1
    address                 192.168.1.100
}

# Service configuration
define service {
    use                     generic-service
    host_name               server1
    service_description     HTTP
    check_command           check_http
}
```

## 🔧 Zabbix

### What is Zabbix?

Zabbix is an enterprise-class open-source monitoring solution for networks and applications. It provides monitoring metrics, visualization, and alerting.

### Key Features

- **Agent-based Monitoring**: Zabbix agents
- **Agentless Monitoring**: SNMP, IPMI, JMX
- **Discovery**: Automatic discovery
- **Templates**: Reusable templates
- **Web Interface**: Rich web UI

### Installation

```bash
# Install Zabbix Server
wget https://repo.zabbix.com/zabbix/6.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_6.0-4+ubuntu22.04_all.deb
sudo dpkg -i zabbix-release_6.0-4+ubuntu22.04_all.deb
sudo apt-get update
sudo apt-get install zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf zabbix-sql-scripts
```

### Configuration

```bash
# Zabbix configuration
# /etc/zabbix/zabbix_server.conf
DBHost=localhost
DBName=zabbix
DBUser=zabbix
DBPassword=password
```

## 📊 Monitoring Setup

### Host Monitoring

```bash
# Add hosts
# Configure monitoring
# Set up checks
# Configure alerts
```

### Service Monitoring

```bash
# Monitor services
# HTTP checks
# Database checks
# Custom checks
```

## 🔔 Alerting

### Notification Configuration

```bash
# Configure notifications
# Email notifications
# SMS notifications
# Webhook notifications
```

## 🎯 Best Practices

1. **Planning**: Plan monitoring strategy
2. **Templates**: Use templates
3. **Alerting**: Configure meaningful alerts
4. **Documentation**: Document configurations
5. **Maintenance**: Regular maintenance
6. **Testing**: Test monitoring setup
7. **Optimization**: Optimize performance

## 🎓 Learning Resources

- Nagios: https://www.nagios.org/documentation/
- Zabbix: https://www.zabbix.com/documentation/
- Monitoring: https://www.nagios.org/products/

---

**Next**: Learn about [CloudWatch Monitoring](./CLOUDWATCH-MONITORING.md)

