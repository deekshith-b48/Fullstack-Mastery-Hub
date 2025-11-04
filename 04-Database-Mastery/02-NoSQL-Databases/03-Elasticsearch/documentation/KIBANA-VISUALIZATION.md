# Kibana Visualization

## 📚 Overview

Kibana is the visualization layer for Elasticsearch, providing dashboards, charts, and search interfaces.

## 🚀 Installation

```bash
# Install Kibana
sudo apt install kibana

# Start Kibana
sudo systemctl start kibana
sudo systemctl enable kibana

# Access Kibana
# http://localhost:5601
```

## 📊 Index Patterns

### Create Index Pattern

1. Go to Management → Stack Management → Index Patterns
2. Create index pattern
3. Select time field (if applicable)
4. Configure field mappings

## 📈 Visualizations

### Create Visualization

1. Go to Analytics → Visualize
2. Create new visualization
3. Choose visualization type:
   - Bar chart
   - Line chart
   - Pie chart
   - Data table
   - Map
   - Metric

### Bar Chart

```javascript
// Example: Employees by department
{
  "aggs": {
    "departments": {
      "terms": {
        "field": "department"
      }
    }
  }
}
```

### Line Chart

```javascript
// Example: Hires over time
{
  "aggs": {
    "hires_over_time": {
      "date_histogram": {
        "field": "hire_date",
        "calendar_interval": "month"
      }
    }
  }
}
```

## 📋 Dashboards

### Create Dashboard

1. Go to Analytics → Dashboard
2. Create new dashboard
3. Add visualizations
4. Arrange layout
5. Save dashboard

## 🔍 Discover

### Search Data

1. Go to Analytics → Discover
2. Select index pattern
3. Search and filter data
4. View documents
5. Save searches

## 🎯 Best Practices

1. **Create meaningful visualizations**
2. **Use appropriate chart types**
3. **Organize dashboards** logically
4. **Share dashboards** with team
5. **Regular updates** to visualizations

---

**Next**: Learn about [Logstash & Beats](./LOGSTASH-BEATS.md)

