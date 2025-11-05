# WebStorm Debugging

WebStorm provides comprehensive debugging capabilities for JavaScript, Node.js, and browser applications. This guide covers debugging setup, breakpoints, and debugging techniques.

## Debugging Overview

WebStorm debugging features:
- **Breakpoints**: Set and manage breakpoints
- **Step Through**: Step through code execution
- **Variable Inspection**: Inspect variables and expressions
- **Call Stack**: Navigate call stack
- **Console**: Evaluate expressions
- **Conditional Breakpoints**: Break on conditions

## Debug Configurations

### Creating Run/Debug Configurations

1. **Run** → **Edit Configurations**
2. Click `+` to add configuration
3. Choose configuration type
4. Configure settings
5. Apply and save

### Configuration Types

#### Node.js

- **Application**: Standard Node.js application
- **Node.js Remote**: Attach to remote Node.js process
- **Jest**: Debug Jest tests
- **Mocha**: Debug Mocha tests

#### JavaScript

- **JavaScript Debug**: Browser debugging
- **Chrome**: Chrome debugging
- **Firefox**: Firefox debugging
- **Edge**: Edge debugging

## Setting Breakpoints

### Line Breakpoints

- **Click**: Click gutter to set breakpoint
- **Toggle**: `Ctrl+F8` / `Cmd+F8`
- **Remove**: Click again or right-click

### Conditional Breakpoints

1. Set breakpoint
2. Right-click → **More**
3. Enter condition
4. Set condition

### Logpoint

1. Set breakpoint
2. Right-click → **More**
3. Enable **Log evaluated expression**
4. Enter expression
5. Continue execution

## Debugging Controls

### Execution Controls

- **Resume**: `F9` - Continue execution
- **Pause**: `Ctrl+F8` - Pause execution
- **Stop**: `Ctrl+F2` / `Cmd+F2` - Stop debugging
- **Restart**: `Ctrl+F5` / `Cmd+F5` - Restart debugging

### Step Controls

- **Step Over**: `F8` - Execute current line
- **Step Into**: `F7` - Enter function call
- **Step Out**: `Shift+F8` - Exit current function
- **Run to Cursor**: `Alt+F9` / `Option+F9` - Run to cursor

## Debug Views

### Variables View

- **Local Variables**: Current scope variables
- **Watch**: Custom watch expressions
- **This**: Current context
- **Closure**: Closure variables

### Call Stack

- **Stack Frames**: Function call hierarchy
- **Navigate**: Click to jump to frame
- **Context**: View context for each frame

### Console

- **Evaluate Expressions**: Evaluate code
- **View Output**: View console output
- **Debug Output**: Debug-specific output

## Debugging Node.js

### Basic Configuration

```json
{
  "type": "node",
  "request": "launch",
  "name": "Debug Node.js",
  "program": "${workspaceFolder}/src/index.js",
  "env": {
    "NODE_ENV": "development"
  }
}
```

### Attaching to Process

1. Start Node with `--inspect` flag
2. Create "Attach to Node.js" configuration
3. Set port (default: 9229)
4. Debug → Attach

### Debugging Express

1. Create Node.js configuration
2. Set entry point
3. Configure environment variables
4. Start debugging

## Browser Debugging

### Chrome Debugging

1. Create Chrome configuration
2. Set URL
3. Configure source maps
4. Start debugging

### Debugging React

1. Install React Developer Tools
2. Create Chrome configuration
3. Set webpack source maps
4. Debug React components

## Debugging Tips

### Effective Debugging

1. **Use Conditional Breakpoints**: Break on specific conditions
2. **Watch Expressions**: Monitor important values
3. **Logpoints**: Log without stopping
4. **Evaluate Expressions**: Test code in console
5. **Navigate Call Stack**: Understand execution flow

### Performance

1. **Disable Breakpoints**: Disable when not needed
2. **Limit Breakpoints**: Too many slow execution
3. **Use Logpoints**: Less intrusive than breakpoints
4. **Skip Libraries**: Skip node_modules

## Advanced Features

### Hot Reload

- **Automatic Reload**: Reload on file changes
- **State Preservation**: Preserve debug state
- **Fast Refresh**: Fast React refresh

### Remote Debugging

- **Attach to Remote**: Debug remote processes
- **Port Forwarding**: Forward debug ports
- **SSH Tunneling**: Debug through SSH

### Source Maps

- **Source Map Support**: Debug original source
- **Webpack Source Maps**: Webpack integration
- **TypeScript Source Maps**: TypeScript support

## Troubleshooting

### Debugging Issues

- **Breakpoints Not Working**: Check source maps
- **Variables Not Showing**: Check scope
- **Can't Attach**: Check port and permissions
- **Slow Performance**: Limit breakpoints

## Next Steps

- Configure [Version Control](./WEBSTORM-VERSION-CONTROL.md)
- Explore [Database Tools](./WEBSTORM-DATABASE-TOOLS.md)
- Optimize [Performance](./WEBSTORM-PERFORMANCE.md)

Effective debugging is essential for development. Master WebStorm's debugging tools to debug faster and more effectively.


