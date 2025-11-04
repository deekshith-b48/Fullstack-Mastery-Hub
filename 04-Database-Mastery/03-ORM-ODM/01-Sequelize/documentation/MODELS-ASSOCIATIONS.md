# Sequelize Models & Associations

## 📚 Overview

Sequelize associations define relationships between models. This guide covers all association types and their configurations.

## 🔗 Association Types

### One-to-Many

```javascript
// User has many Posts
const User = sequelize.define('User', {
    name: DataTypes.STRING
});

const Post = sequelize.define('Post', {
    title: DataTypes.STRING,
    content: DataTypes.TEXT
});

User.hasMany(Post, {
    foreignKey: 'userId',
    as: 'posts'
});

Post.belongsTo(User, {
    foreignKey: 'userId',
    as: 'author'
});

// Usage
const user = await User.findByPk(1, {
    include: [{
        model: Post,
        as: 'posts'
    }]
});

const post = await Post.findByPk(1, {
    include: [{
        model: User,
        as: 'author'
    }]
});
```

### Many-to-Many

```javascript
// User belongs to many Roles
const User = sequelize.define('User', {
    name: DataTypes.STRING
});

const Role = sequelize.define('Role', {
    name: DataTypes.STRING
});

User.belongsToMany(Role, {
    through: 'UserRoles',
    foreignKey: 'userId',
    otherKey: 'roleId'
});

Role.belongsToMany(User, {
    through: 'UserRoles',
    foreignKey: 'roleId',
    otherKey: 'userId'
});

// Usage
const user = await User.findByPk(1, {
    include: [{
        model: Role,
        through: { attributes: [] }  // Exclude join table attributes
    }]
});
```

### One-to-One

```javascript
// User has one Profile
const User = sequelize.define('User', {
    name: DataTypes.STRING
});

const Profile = sequelize.define('Profile', {
    bio: DataTypes.TEXT,
    avatar: DataTypes.STRING
});

User.hasOne(Profile, {
    foreignKey: 'userId',
    as: 'profile'
});

Profile.belongsTo(User, {
    foreignKey: 'userId',
    as: 'user'
});

// Usage
const user = await User.findByPk(1, {
    include: [{
        model: Profile,
        as: 'profile'
    }]
});
```

## 🔄 Association Options

### Foreign Key

```javascript
User.hasMany(Post, {
    foreignKey: 'authorId',  // Custom foreign key name
    sourceKey: 'id'          // Source key (default: primary key)
});
```

### Aliases

```javascript
User.hasMany(Post, {
    as: 'posts'  // Alias for include
});
```

### Hooks

```javascript
User.hasMany(Post, {
    hooks: true,  // Enable hooks
    onDelete: 'CASCADE',
    onUpdate: 'CASCADE'
});
```

## 🎯 Best Practices

1. **Define associations** in both directions
2. **Use aliases** for clarity
3. **Configure foreign keys** explicitly
4. **Use through** for many-to-many
5. **Handle cascading** deletes appropriately

---

**Next**: Learn about [Migrations & Seeding](./MIGRATIONS-SEEDING.md)

