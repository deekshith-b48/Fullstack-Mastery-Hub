# VS Code Snippets

Code snippets are templates that make it easier to enter repeating code patterns. VS Code supports snippets for all languages and allows you to create custom snippets.

## Understanding Snippets

Snippets are:
- Pre-defined code templates
- Triggered by prefixes or commands
- Customizable with placeholders
- Support for multiple cursors
- Variable substitution

## Built-in Snippets

VS Code includes snippets for many languages:
- JavaScript/TypeScript
- HTML/CSS
- Python
- Java
- C/C++
- And more...

### Using Built-in Snippets

1. Type snippet prefix
2. Select snippet from suggestions
3. Press `Tab` to accept
4. Fill in placeholders

### Example: JavaScript

- `log`: `console.log()`
- `for`: `for` loop
- `if`: `if` statement
- `fn`: Function declaration

## Creating Custom Snippets

### Accessing Snippet Editor

1. Command Palette: "Preferences: Configure User Snippets"
2. Select language or create new file
3. Edit JSON snippet file

### Snippet File Location

- **User Snippets**: `~/.config/Code/User/snippets/`
- **Workspace Snippets**: `.vscode/snippets/`

### Snippet Format

```json
{
  "Snippet Name": {
    "prefix": "trigger",
    "body": [
      "line 1",
      "line 2"
    ],
    "description": "Snippet description"
  }
}
```

## Snippet Syntax

### Basic Snippet

```json
{
  "Console Log": {
    "prefix": "clog",
    "body": [
      "console.log('$1');",
      "$2"
    ],
    "description": "Console log statement"
  }
}
```

### Placeholders

```json
{
  "Function": {
    "prefix": "fn",
    "body": [
      "function ${1:functionName}(${2:params}) {",
      "\t$3",
      "}"
    ],
    "description": "Function declaration"
  }
}
```

### Tab Stops

- `${1}`: First cursor position
- `${2}`: Second cursor position
- `${1:default}`: Placeholder with default value
- `${1|choice1,choice2|}`: Choice menu

### Variables

```json
{
  "File Header": {
    "prefix": "header",
    "body": [
      "/**",
      " * $1",
      " * @author ${TM_FULLNAME}",
      " * @date ${CURRENT_YEAR}-${CURRENT_MONTH}-${CURRENT_DATE}",
      " */"
    ]
  }
}
```

### Common Variables

- `${TM_FILENAME}`: Current filename
- `${TM_DIRECTORY}`: Directory of current file
- `${TM_FILEPATH}`: Full file path
- `${CURRENT_YEAR}`: Current year
- `${CURRENT_MONTH}`: Current month
- `${CURRENT_DATE}`: Current date
- `${CURRENT_HOUR}`: Current hour
- `${CURRENT_MINUTE}`: Current minute
- `${CURRENT_SECOND}`: Current second
- `${CLIPBOARD}`: Clipboard contents
- `${TM_SELECTED_TEXT}`: Selected text

## Snippet Examples

### React Component

```json
{
  "React Functional Component": {
    "prefix": "rfc",
    "body": [
      "import React from 'react';",
      "",
      "const ${1:ComponentName} = () => {",
      "\treturn (",
      "\t\t<div>",
      "\t\t\t$2",
      "\t\t</div>",
      "\t);",
      "};",
      "",
      "export default ${1:ComponentName};"
    ],
    "description": "React functional component"
  }
}
```

### Express Route

```json
{
  "Express Route": {
    "prefix": "route",
    "body": [
      "router.${1|get,post,put,delete|}('${2:/path}', (req, res) => {",
      "\ttry {",
      "\t\t$3",
      "\t\tres.status(200).json({ success: true });",
      "\t} catch (error) {",
      "\t\tres.status(500).json({ error: error.message });",
      "\t}",
      "});"
    ],
    "description": "Express route handler"
  }
}
```

### Async Function

```json
{
  "Async Function": {
    "prefix": "async",
    "body": [
      "const ${1:functionName} = async (${2:params}) => {",
      "\ttry {",
      "\t\t$3",
      "\t} catch (error) {",
      "\t\tconsole.error('Error:', error);",
      "\t\tthrow error;",
      "\t}",
      "};"
    ],
    "description": "Async function with error handling"
  }
}
```

## Advanced Snippet Features

### Multiple Cursors

```json
{
  "Multiple Variables": {
    "prefix": "vars",
    "body": [
      "const ${1:var1} = $2;",
      "const ${1:var1} = $3;",
      "const ${1:var1} = $4;"
    ]
  }
}
```

### Transformations

```json
{
  "Import Statement": {
    "prefix": "import",
    "body": [
      "import ${1:${TM_FILENAME_BASE/(.*)/${1:/capitalize}/}} from './${1}';"
    ]
  }
}
```

### Regular Expressions

Transformations use regex:
- `${TM_FILENAME_BASE/(.*)/${1:/upcase}/}`: Uppercase
- `${TM_FILENAME_BASE/(.*)/${1:/downcase}/}`: Lowercase
- `${TM_FILENAME_BASE/(.*)/${1:/capitalize}/}`: Capitalize

### Choice Menus

```json
{
  "HTTP Method": {
    "prefix": "http",
    "body": [
      "${1|GET,POST,PUT,DELETE|}"
    ]
  }
}
```

## Snippet Scope

### Language-Specific Snippets

```json
{
  "JavaScript Snippet": {
    "scope": "javascript",
    "prefix": "js",
    "body": ["console.log('$1');"]
  }
}
```

### Multiple Scopes

```json
{
  "Comment": {
    "scope": "javascript,javascriptreact,typescript,typescriptreact",
    "prefix": "comment",
    "body": ["// $1"]
  }
}
```

## Snippet Extensions

### Popular Snippet Extensions

- **ES7+ React/Redux/React-Native snippets**: React snippets
- **JavaScript (ES6) code snippets**: ES6 snippets
- **Python snippets**: Python snippets
- **HTML Snippets**: HTML snippets
- **CSS Snippets**: CSS snippets

### Installing Snippet Extensions

1. Open Extensions view
2. Search for "snippets"
3. Install extension
4. Use snippets immediately

## Snippet Best Practices

### Naming Conventions

- Use descriptive prefixes
- Keep prefixes short
- Use consistent naming
- Avoid conflicts with built-in snippets

### Organization

- Group related snippets
- Use comments in JSON
- Organize by category
- Keep snippets focused

### Documentation

- Add descriptions
- Include examples
- Document placeholders
- Explain transformations

## Workspace Snippets

### Creating Workspace Snippets

1. Create `.vscode/snippets/` folder
2. Create language-specific files
3. Add snippets to files
4. Share with team

### Example Structure

```
.vscode/
  snippets/
    javascript.json
    typescript.json
    python.json
```

## Snippet Tips

### Quick Access

- Use Command Palette: "Insert Snippet"
- Type prefix in editor
- Browse available snippets

### Editing Snippets

- Edit snippet files directly
- Reload window after changes
- Test snippets immediately

### Sharing Snippets

- Copy snippet JSON
- Share via GitHub Gist
- Create snippet extension
- Include in workspace

## Troubleshooting

### Snippets Not Working

1. Check snippet scope matches file type
2. Verify prefix is correct
3. Check JSON syntax
4. Reload VS Code window

### Snippets Not Appearing

1. Check IntelliSense is enabled
2. Verify snippet is in correct file
3. Check file scope matches
4. Clear VS Code cache

## Next Steps

- Learn about [Themes and Customization](./VSCODE-THEMES-CUSTOMIZATION.md)
- Explore [Workspaces](./VSCODE-WORKSPACES.md)
- Optimize [Performance](./VSCODE-PERFORMANCE.md)

Snippets are a powerful productivity tool. Create custom snippets for your common patterns to code faster and more consistently.


