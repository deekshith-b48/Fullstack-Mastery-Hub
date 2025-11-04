# TypeORM Entities & Relations

## 📚 Overview

TypeORM supports various relationship types between entities. This guide covers one-to-one, one-to-many, and many-to-many relationships.

## 🔗 One-to-Many

```typescript
// User entity
@Entity()
export class User {
    @PrimaryGeneratedColumn()
    id: number;

    @OneToMany(() => Post, post => post.author)
    posts: Post[];
}

// Post entity
@Entity()
export class Post {
    @PrimaryGeneratedColumn()
    id: number;

    @ManyToOne(() => User, user => user.posts)
    @JoinColumn({ name: 'author_id' })
    author: User;
}
```

## 👥 Many-to-Many

```typescript
// User entity
@Entity()
export class User {
    @PrimaryGeneratedColumn()
    id: number;

    @ManyToMany(() => Role, role => role.users)
    @JoinTable({
        name: 'user_roles',
        joinColumn: { name: 'user_id', referencedColumnName: 'id' },
        inverseJoinColumn: { name: 'role_id', referencedColumnName: 'id' }
    })
    roles: Role[];
}

// Role entity
@Entity()
export class Role {
    @PrimaryGeneratedColumn()
    id: number;

    @ManyToMany(() => User, user => user.roles)
    users: User[];
}
```

## 🔗 One-to-One

```typescript
// User entity
@Entity()
export class User {
    @PrimaryGeneratedColumn()
    id: number;

    @OneToOne(() => Profile, profile => profile.user)
    @JoinColumn()
    profile: Profile;
}

// Profile entity
@Entity()
export class Profile {
    @PrimaryGeneratedColumn()
    id: number;

    @OneToOne(() => User, user => user.profile)
    user: User;
}
```

## 🔍 Loading Relations

```typescript
// Eager loading
@Entity()
export class User {
    @OneToMany(() => Post, post => post.author, { eager: true })
    posts: Post[];
}

// Lazy loading
const user = await userRepository.findOne({
    where: { id: 1 },
    relations: ['posts']
});
```

## 🎯 Best Practices

1. **Define relations** in both entities
2. **Use appropriate relation types**
3. **Configure join columns** explicitly
4. **Use eager loading** carefully
5. **Handle cascading** operations

---

**Next**: Learn about [Migrations & CLI](./MIGRATIONS-CLI.md)

