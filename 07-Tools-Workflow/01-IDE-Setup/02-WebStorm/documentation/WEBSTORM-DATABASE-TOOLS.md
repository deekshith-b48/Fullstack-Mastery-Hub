# WebStorm Database Tools

WebStorm includes integrated database tools for working with SQL databases. This guide covers database connections, query execution, and database management.

## Database Tools Overview

WebStorm database features:
- **Database Navigator**: Browse databases visually
- **Query Console**: Execute SQL queries
- **Schema Visualization**: Visualize database structure
- **Data Editor**: Edit table data
- **Auto-Complete**: SQL code completion
- **Multiple Databases**: Support for various databases

## Supported Databases

### SQL Databases

- **MySQL**: MySQL database support
- **PostgreSQL**: PostgreSQL support
- **SQLite**: SQLite database support
- **Oracle**: Oracle database support
- **SQL Server**: Microsoft SQL Server
- **MariaDB**: MariaDB support

### NoSQL Databases

- **MongoDB**: MongoDB support (via plugin)
- **Redis**: Redis support (via plugin)

## Database Navigator

### Opening Database Navigator

- **View** → **Tool Windows** → **Database**
- **Alt+1** → **Database** tab
- Browse databases and tables

### Database Structure

- **Databases**: List of databases
- **Schemas**: Database schemas
- **Tables**: Database tables
- **Views**: Database views
- **Procedures**: Stored procedures
- **Functions**: Database functions

## Connecting to Databases

### Data Source Configuration

1. **View** → **Tool Windows** → **Database**
2. Click `+` → **Data Source**
3. Select database type
4. Configure connection
5. Test connection
6. Apply

### Connection Settings

- **Host**: Database host
- **Port**: Database port
- **Database**: Database name
- **User**: Username
- **Password**: Password
- **URL**: Connection URL
- **Driver**: Database driver

### Connection Types

- **Direct**: Direct database connection
- **SSH Tunnel**: Connect via SSH
- **SSL**: Secure SSL connection
- **Cloud**: Cloud database connections

## Query Console

### Opening Query Console

1. **Right-click** database → **Open Console**
2. **Right-click** table → **Open Console**
3. **Alt+4**: Open Query Console

### Executing Queries

1. Type SQL query
2. **Ctrl+Enter** / `Cmd+Enter`: Execute query
3. View results
4. Multiple queries: Execute separately

### Query Features

- **Syntax Highlighting**: SQL syntax support
- **Auto-Complete**: Code completion
- **Error Detection**: Query validation
- **Result Viewing**: View query results
- **Export Results**: Export query results

## Schema Visualization

### Database Diagram

1. **Right-click** database → **Diagrams** → **Show Visualization**
2. View database schema
3. Navigate relationships
4. Export diagram

### Table Relationships

- **Foreign Keys**: View relationships
- **Dependencies**: See dependencies
- **ER Diagrams**: Entity-relationship diagrams

## Data Editor

### Viewing Data

1. **Right-click** table → **Open with** → **Table Editor**
2. View table data
3. Edit data inline
4. Save changes

### Editing Data

- **Insert Row**: Add new rows
- **Edit Cell**: Edit cell values
- **Delete Row**: Remove rows
- **Commit Changes**: Save changes

## SQL Code Assistance

### Auto-Complete

- **Table Names**: Complete table names
- **Column Names**: Complete column names
- **SQL Keywords**: Complete SQL syntax
- **Functions**: Complete SQL functions

### Code Generation

- **Generate SELECT**: Generate SELECT queries
- **Generate INSERT**: Generate INSERT statements
- **Generate UPDATE**: Generate UPDATE statements
- **Generate DELETE**: Generate DELETE statements

## Advanced Features

### Query History

- **View History**: See executed queries
- **Reuse Queries**: Execute previous queries
- **Search History**: Search query history

### Export/Import

- **Export Data**: Export table data
- **Import Data**: Import data to tables
- **Export Schema**: Export database schema
- **Import Schema**: Import database schema

### Database Scripts

- **Generate Scripts**: Generate SQL scripts
- **Run Scripts**: Execute SQL scripts
- **Script Templates**: Use script templates

## Best Practices

### Database Management

1. **Use Connections**: Reuse connections
2. **Test Queries**: Test before executing
3. **Backup Data**: Backup before changes
4. **Use Transactions**: Use transactions for safety

### Performance

1. **Index Queries**: Index frequently queried columns
2. **Limit Results**: Limit result sets
3. **Optimize Queries**: Optimize SQL queries
4. **Connection Pooling**: Use connection pooling

## Troubleshooting

### Connection Issues

- **Check Credentials**: Verify username/password
- **Network**: Check network connectivity
- **Firewall**: Check firewall settings
- **Driver**: Verify driver installation

## Next Steps

- Optimize [Performance](./WEBSTORM-PERFORMANCE.md)
- Compare [VS Code](./WEBSTORM-VS-VSCODE.md)
- Explore [Features](./WEBSTORM-FEATURES.md)

Database tools streamline database development. Use WebStorm's database features for efficient database management.


