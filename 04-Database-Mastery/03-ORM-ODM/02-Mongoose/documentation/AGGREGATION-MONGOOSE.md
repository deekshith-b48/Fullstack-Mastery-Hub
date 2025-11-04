# Mongoose Aggregation

## 📚 Overview

Mongoose provides aggregation pipeline support for complex data processing and analysis.

## 🔄 Aggregation Pipeline

### Basic Aggregation

```javascript
// Simple aggregation
const result = await User.aggregate([
    { $match: { department: 'IT' } },
    { $group: { _id: '$department', count: { $sum: 1 } } }
]);
```

### Common Stages

```javascript
// $match - Filter documents
await User.aggregate([
    { $match: { age: { $gt: 25 } } }
]);

// $group - Group documents
await User.aggregate([
    {
        $group: {
            _id: '$department',
            avgSalary: { $avg: '$salary' },
            count: { $sum: 1 }
        }
    }
]);

// $project - Reshape documents
await User.aggregate([
    {
        $project: {
            fullName: { $concat: ['$firstName', ' ', '$lastName'] },
            salary: 1
        }
    }
]);

// $sort - Sort documents
await User.aggregate([
    { $sort: { salary: -1 } }
]);

// $limit - Limit results
await User.aggregate([
    { $limit: 10 }
]);

// $skip - Skip documents
await User.aggregate([
    { $skip: 20 },
    { $limit: 10 }
]);
```

### Complex Aggregation

```javascript
const result = await User.aggregate([
    // Stage 1: Filter
    { $match: { salary: { $gt: 50000 } } },
    
    // Stage 2: Group
    {
        $group: {
            _id: '$department',
            avgSalary: { $avg: '$salary' },
            maxSalary: { $max: '$salary' },
            minSalary: { $min: '$salary' },
            count: { $sum: 1 }
        }
    },
    
    // Stage 3: Filter groups
    { $match: { count: { $gt: 5 } } },
    
    // Stage 4: Sort
    { $sort: { avgSalary: -1 } }
]);
```

## 🎯 Best Practices

1. **Use $match early** to reduce documents
2. **Index fields** used in $match and $sort
3. **Limit results** with $limit
4. **Project only needed fields** with $project
5. **Monitor performance** of aggregations

---

**Next**: Learn about [Performance Optimization](./PERFORMANCE-OPTIMIZATION.md)

