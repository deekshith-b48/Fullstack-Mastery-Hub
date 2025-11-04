# MongoDB Aggregation Framework

## 📚 Overview

The MongoDB Aggregation Framework provides a powerful way to process and transform documents. It's similar to SQL's GROUP BY but more flexible.

## 🔄 Aggregation Pipeline

### Basic Pipeline

```javascript
// Simple aggregation
db.employees.aggregate([
    { $match: { department: "IT" } },
    { $group: { _id: "$department", count: { $sum: 1 } } }
])
```

### Pipeline Stages

```javascript
// $match - Filter documents
db.employees.aggregate([
    { $match: { salary: { $gt: 70000 } } }
])

// $group - Group documents
db.employees.aggregate([
    {
        $group: {
            _id: "$department",
            avgSalary: { $avg: "$salary" },
            count: { $sum: 1 }
        }
    }
])

// $project - Reshape documents
db.employees.aggregate([
    {
        $project: {
            fullName: { $concat: ["$first_name", " ", "$last_name"] },
            salary: 1
        }
    }
])

// $sort - Sort documents
db.employees.aggregate([
    { $sort: { salary: -1 } }
])

// $limit - Limit results
db.employees.aggregate([
    { $limit: 10 }
])

// $skip - Skip documents
db.employees.aggregate([
    { $skip: 20 },
    { $limit: 10 }
])
```

### Complex Aggregation

```javascript
// Multi-stage aggregation
db.employees.aggregate([
    // Stage 1: Filter
    { $match: { salary: { $gt: 50000 } } },
    
    // Stage 2: Group
    {
        $group: {
            _id: "$department",
            avgSalary: { $avg: "$salary" },
            maxSalary: { $max: "$salary" },
            minSalary: { $min: "$salary" },
            count: { $sum: 1 }
        }
    },
    
    // Stage 3: Filter groups
    { $match: { count: { $gt: 5 } } },
    
    // Stage 4: Sort
    { $sort: { avgSalary: -1 } }
])
```

## 📊 Aggregation Operators

### Arithmetic Operators

```javascript
// $add, $subtract, $multiply, $divide
db.employees.aggregate([
    {
        $project: {
            name: 1,
            salary: 1,
            newSalary: { $multiply: ["$salary", 1.1] }
        }
    }
])
```

### Comparison Operators

```javascript
// $eq, $ne, $gt, $gte, $lt, $lte
db.employees.aggregate([
    {
        $project: {
            name: 1,
            isHighSalary: { $gt: ["$salary", 100000] }
        }
    }
])
```

### String Operators

```javascript
// $concat, $substr, $toLower, $toUpper
db.employees.aggregate([
    {
        $project: {
            fullName: { $concat: ["$first_name", " ", "$last_name"] },
            emailLower: { $toLower: "$email" }
        }
    }
])
```

### Date Operators

```javascript
// $year, $month, $dayOfMonth
db.employees.aggregate([
    {
        $project: {
            name: 1,
            hireYear: { $year: "$hire_date" },
            hireMonth: { $month: "$hire_date" }
        }
    }
])
```

## 🎯 Best Practices

1. **Use $match early** to reduce documents
2. **Index fields** used in $match and $sort
3. **Limit results** with $limit
4. **Project only needed fields** with $project
5. **Use $allowDiskUse** for large datasets
6. **Monitor performance** with explain()

---

**Next**: Learn about [Indexing Strategies](./INDEXING-STRATEGIES.md)

