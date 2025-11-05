# VS Code Debugging

VS Code has built-in debugging support for multiple languages. This guide covers how to set up and use the debugger effectively.

## Debugging Overview

VS Code's debugger provides:
- Breakpoints and conditional breakpoints
- Step-through debugging
- Variable inspection
- Call stack navigation
- Watch expressions
- Debug console

## Debug Panel

Access the Debug panel:
- `Ctrl+Shift+D` / `Cmd+Shift+D`
- Click Debug icon in Activity Bar
- View > Run and Debug

### Debug Views

- **Variables**: Shows variables in current scope
- **Watch**: Custom expressions to monitor
- **Call Stack**: Function call hierarchy
- **Breakpoints**: List of all breakpoints
- **Loaded Scripts**: Scripts loaded in debug session

## Setting Up Debugging

### Launch Configuration

Create `.vscode/launch.json`:

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "type": "node",
      "request": "launch",
      "name": "Launch Program",
      "skipFiles": ["<node_internals>/**"],
      "program": "${workspaceFolder}/index.js"
    }
  ]
}
```

### Configuration Properties

- **type**: Debugger type (node, chrome, python, etc.)
- **request**: "launch" or "attach"
- **name**: Display name
- **program**: Entry point file
- **args**: Command-line arguments
- **env**: Environment variables
- **cwd**: Working directory

## Node.js Debugging

### Basic Configuration

```json
{
  "type": "node",
  "request": "launch",
  "name": "Launch Node.js",
  "program": "${workspaceFolder}/src/index.js",
  "skipFiles": ["<node_internals>/**"],
  "console": "integratedTerminal"
}
```

### Node.js with Nodemon

```json
{
  "type": "node",
  "request": "launch",
  "name": "Launch with Nodemon",
  "runtimeExecutable": "nodemon",
  "program": "${workspaceFolder}/src/index.js",
  "restart": true,
  "console": "integratedTerminal"
}
```

### Attach to Node.js

```json
{
  "type": "node",
  "request": "attach",
  "name": "Attach to Node",
  "port": 9229,
  "restart": true
}
```

Start Node with debug flag:
```bash
node --inspect=9229 index.js
```

## Browser Debugging

### Chrome/Edge Debugging

```json
{
  "type": "chrome",
  "request": "launch",
  "name": "Launch Chrome",
  "url": "http://localhost:3000",
  "webRoot": "${workspaceFolder}/src",
  "sourceMaps": true
}
```

### Attach to Chrome

```json
{
  "type": "chrome",
  "request": "attach",
  "name": "Attach to Chrome",
  "port": 9222,
  "webRoot": "${workspaceFolder}/src"
}
```

Start Chrome with remote debugging:
```bash
chrome --remote-debugging-port=9222
```

## Breakpoints

### Setting Breakpoints

- Click left margin next to line number
- `F9` to toggle breakpoint
- `Ctrl+Shift+F9` / `Cmd+Shift+F9` to clear all

### Breakpoint Types

1. **Line Breakpoint**: Pauses at specific line
2. **Conditional Breakpoint**: Pauses when condition is true
3. **Logpoint**: Logs message without stopping
4. **Function Breakpoint**: Pauses at function entry

### Conditional Breakpoints

Right-click breakpoint → Edit Breakpoint:
- Condition: `x > 10`
- Hit Count: `> 5`
- Log Message: `Current value: {x}`

### Logpoints

Output to Debug Console without stopping:
```
Log Message: Variable x = {x}, y = {y}
```

## Debugging Controls

### Execution Controls

- `F5`: Start/Continue
- `Shift+F5`: Stop
- `Ctrl+Shift+F5` / `Cmd+Shift+F5`: Restart
- `F9`: Toggle breakpoint
- `F10`: Step over
- `F11`: Step into
- `Shift+F11`: Step out

### Navigation

- **Step Over** (`F10`): Execute current line
- **Step Into** (`F11`): Enter function call
- **Step Out** (`Shift+F11`): Exit current function
- **Continue** (`F5`): Resume execution

## Variable Inspection

### Variables View

- Shows variables in current scope
- Expand objects to see properties
- Hover over variables in editor
- Right-click to set value

### Watch Expressions

Add expressions to watch:
- Click `+` in Watch view
- Enter expression: `array.length`, `obj.property`
- Expressions update during debugging

### Debug Console

Evaluate expressions:
- Type expressions in Debug Console
- Access variables and functions
- Execute code in current context

## Source Maps

### Configuration

```json
{
  "sourceMaps": true,
  "sourceMapPathOverrides": {
    "webpack:///./*": "${webRoot}/*",
    "webpack:///src/*": "${webRoot}/*"
  }
}
```

## Debugging Scenarios

### React Applications

```json
{
  "type": "chrome",
  "request": "launch",
  "name": "Launch React",
  "url": "http://localhost:3000",
  "webRoot": "${workspaceFolder}/src",
  "sourceMaps": true,
  "sourceMapPathOverrides": {
    "webpack:///src/*": "${webRoot}/*"
  }
}
```

### Express.js Applications

```json
{
  "type": "node",
  "request": "launch",
  "name": "Launch Express",
  "program": "${workspaceFolder}/server.js",
  "env": {
    "NODE_ENV": "development"
  },
  "console": "integratedTerminal"
}
```

### Python Applications

```json
{
  "type": "python",
  "request": "launch",
  "name": "Python: Current File",
  "program": "${file}",
  "console": "integratedTerminal",
  "justMyCode": true
}
```

## Advanced Debugging

### Compound Configurations

Debug multiple targets:

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "type": "node",
      "request": "launch",
      "name": "Server",
      "program": "${workspaceFolder}/server.js"
    },
    {
      "type": "chrome",
      "request": "launch",
      "name": "Client",
      "url": "http://localhost:3000"
    }
  ],
  "compounds": [
    {
      "name": "Full Stack",
      "configurations": ["Server", "Client"]
    }
  ]
}
```

### Pre-Launch Tasks

Run tasks before debugging:

```json
{
  "type": "node",
  "request": "launch",
  "name": "Launch with Build",
  "preLaunchTask": "npm: build",
  "program": "${workspaceFolder}/dist/index.js"
}
```

### Post-Debug Actions

```json
{
  "type": "node",
  "request": "launch",
  "name": "Launch with Cleanup",
  "program": "${workspaceFolder}/index.js",
  "postDebugTask": "cleanup"
}
```

## Debugging Tips

### Skip Files

Skip node_modules or library code:

```json
{
  "skipFiles": [
    "<node_internals>/**",
    "${workspaceFolder}/node_modules/**"
  ]
}
```

### Smart Stepping

- Use "Step Over" for library code
- Use "Step Into" for your code
- Use "Step Out" to exit current function quickly

### Debug Console

- Evaluate expressions
- Call functions
- Inspect objects
- Modify variables

## Troubleshooting

### Breakpoints Not Working

1. Check source maps are enabled
2. Verify file paths match
3. Check skipFiles configuration
4. Ensure debugger extension is installed

### Variables Not Showing

1. Check execution is paused
2. Verify scope is correct
3. Check variable is in scope
4. Use Debug Console as alternative

### Source Maps Issues

1. Verify source maps are generated
2. Check sourceMapPathOverrides
3. Ensure webRoot is correct
4. Check source map format

## Extension Debuggers

### Python Debugger

Install Python extension:
- Provides Python debugging support
- Supports virtual environments
- Integrated with pytest

### C++ Debugger

Install C++ extension:
- GDB/LLDB support
- Multi-file debugging
- Memory inspection

### Java Debugger

Install Java Extension Pack:
- JVM debugging
- Spring Boot support
- Maven/Gradle integration

## Best Practices

1. **Use Conditional Breakpoints**: Reduce stopping at every iteration
2. **Leverage Logpoints**: Log without stopping execution
3. **Watch Expressions**: Monitor important values
4. **Skip Files**: Skip library code for faster debugging
5. **Organize Configurations**: Use compound configs for complex setups
6. **Use Debug Console**: Evaluate expressions on the fly

## Next Steps

- Learn about [Integrated Terminal](./VSCODE-INTEGRATED-TERMINAL.md)
- Explore [Workspaces](./VSCODE-WORKSPACES.md)
- Optimize [Performance](./VSCODE-PERFORMANCE.md)

Effective debugging is essential for efficient development. Master these techniques to debug faster and more effectively.


