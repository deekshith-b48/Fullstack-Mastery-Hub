# SQL Server Stored Procedures

## 📚 Overview

Stored procedures are precompiled SQL statements stored in the database. They improve performance, security, and code reusability. This guide covers creating, managing, and optimizing stored procedures.

## 🎯 Creating Stored Procedures

### Basic Stored Procedure

```sql
-- Simple stored procedure
CREATE PROCEDURE GetEmployees
AS
BEGIN
    SELECT * FROM employees;
END;

-- Execute procedure
EXEC GetEmployees;
```

### Stored Procedure with Parameters

```sql
-- With input parameters
CREATE PROCEDURE GetEmployeeById
    @EmployeeId INT
AS
BEGIN
    SELECT * FROM employees WHERE id = @EmployeeId;
END;

-- Execute with parameter
EXEC GetEmployeeById @EmployeeId = 1;

-- With multiple parameters
CREATE PROCEDURE GetEmployeesByDepartment
    @DepartmentId INT,
    @MinSalary DECIMAL(10, 2) = 50000
AS
BEGIN
    SELECT * FROM employees 
    WHERE department_id = @DepartmentId 
    AND salary >= @MinSalary;
END;

-- Execute
EXEC GetEmployeesByDepartment @DepartmentId = 5, @MinSalary = 70000;
```

### Output Parameters

```sql
-- Stored procedure with output parameter
CREATE PROCEDURE GetEmployeeCount
    @DepartmentId INT,
    @Count INT OUTPUT
AS
BEGIN
    SELECT @Count = COUNT(*) 
    FROM employees 
    WHERE department_id = @DepartmentId;
END;

-- Execute with output
DECLARE @Result INT;
EXEC GetEmployeeCount @DepartmentId = 5, @Count = @Result OUTPUT;
SELECT @Result AS employee_count;
```

### Return Values

```sql
-- Stored procedure with return value
CREATE PROCEDURE CheckEmployeeExists
    @EmployeeId INT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM employees WHERE id = @EmployeeId)
        RETURN 1;
    ELSE
        RETURN 0;
END;

-- Execute
DECLARE @Exists INT;
EXEC @Exists = CheckEmployeeExists @EmployeeId = 1;
SELECT @Exists AS exists;
```

## 🔄 Modifying Stored Procedures

```sql
-- Alter stored procedure
ALTER PROCEDURE GetEmployees
AS
BEGIN
    SELECT id, first_name, last_name, email 
    FROM employees
    ORDER BY last_name;
END;

-- Drop stored procedure
DROP PROCEDURE GetEmployees;
```

## 📊 Advanced Features

### Error Handling

```sql
-- Stored procedure with error handling
CREATE PROCEDURE UpdateEmployeeSalary
    @EmployeeId INT,
    @NewSalary DECIMAL(10, 2)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;
        
        UPDATE employees 
        SET salary = @NewSalary 
        WHERE id = @EmployeeId;
        
        IF @@ROWCOUNT = 0
            THROW 50001, 'Employee not found', 1;
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
```

### Dynamic SQL in Stored Procedures

```sql
-- Stored procedure with dynamic SQL
CREATE PROCEDURE SearchEmployees
    @ColumnName NVARCHAR(100),
    @SearchValue NVARCHAR(100)
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX);
    SET @sql = 'SELECT * FROM employees WHERE ' + @ColumnName + ' = @value';
    EXEC sp_executesql @sql, N'@value NVARCHAR(100)', @value = @SearchValue;
END;
```

## 🎯 Best Practices

1. **Use parameters** instead of string concatenation
2. **Handle errors** properly with TRY...CATCH
3. **Use transactions** for multiple operations
4. **Document procedures** with comments
5. **Return appropriate values** or result sets
6. **Test thoroughly** before deployment

---

**Next**: Learn about [Indexing](./INDEXING-SQL-SERVER.md)

