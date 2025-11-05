# Sublime Text Snippets

Snippets are code templates that expand into larger code blocks. Sublime Text has powerful snippet support with variables, placeholders, and tab stops.

## Snippet Overview

Snippets provide:
- **Code Templates**: Pre-defined code patterns
- **Tab Stops**: Navigate between placeholders
- **Variables**: Dynamic content insertion
- **Customization**: Create custom snippets

## Built-in Snippets

Sublime Text includes snippets for:
- **HTML**: HTML tags and structures
- **CSS**: CSS properties and values
- **JavaScript**: JavaScript patterns
- **Python**: Python code patterns

## Using Snippets

### Triggering Snippets

1. Type snippet trigger
2. Press `Tab` to expand
3. Fill in placeholders
4. Navigate with `Tab`

### Example

Type `div` and press `Tab`:
```html
<div>$0</div>
```

## Creating Snippets

### Snippet File Location

- **User Snippets**: `Packages/User/`
- **Language-Specific**: Language package folders
- **File Format**: `.sublime-snippet`

### Snippet Structure

```xml
<snippet>
  <content><![CDATA[
    snippet content
  ]]></content>
  <tabTrigger>trigger</tabTrigger>
  <scope>source.js</scope>
  <description>Description</description>
</snippet>
```

### Snippet Elements

- **content**: Snippet code
- **tabTrigger**: Trigger text
- **scope**: Language scope
- **description**: Snippet description

## Tab Stops

### Basic Tab Stops

```xml
<snippet>
  <content><![CDATA[
    function ${1:functionName}(${2:params}) {
      $3
    }
  ]]></content>
</snippet>
```

### Tab Stop Order

- `${1}`: First cursor position
- `${2}`: Second position
- `${0}`: Final cursor position

## Variables

### Built-in Variables

- `$TM_FILENAME`: Current filename
- `$TM_DIRECTORY`: Current directory
- `$TM_FILEPATH`: Full file path
- `$TM_CURRENT_WORD`: Selected word
- `$TM_SELECTED_TEXT`: Selected text
- `$TM_CURRENT_LINE`: Current line
- `$TM_LINE_NUMBER`: Line number
- `$TM_COLUMN_NUMBER`: Column number

### Date/Time Variables

- `$TM_YEAR`: Current year
- `$TM_MONTH`: Current month
- `$TM_DAY`: Current day
- `$TM_HOUR`: Current hour
- `$TM_MINUTE`: Current minute

### Using Variables

```xml
<content><![CDATA[
  /**
   * ${1:Description}
   * @author $TM_FULLNAME
   * @date $TM_YEAR-$TM_MONTH-$TM_DAY
   */
]]></content>
```

## Placeholders

### Default Values

```xml
<content><![CDATA[
  const ${1:variableName} = ${2:value};
]]></content>
```

### Mirrored Placeholders

Same placeholder number = same value:
```xml
<content><![CDATA[
  function ${1:name}() {
    return ${1:name};
  }
]]></content>
```

## Example Snippets

### React Component

```xml
<snippet>
  <content><![CDATA[
    import React from 'react';

    const ${1:ComponentName} = () => {
      return (
        <div>
          $2
        </div>
      );
    };

    export default ${1:ComponentName};
  ]]></content>
  <tabTrigger>rfc</tabTrigger>
  <scope>source.js.jsx</scope>
</snippet>
```

### Express Route

```xml
<snippet>
  <content><![CDATA[
    router.${1|get,post,put,delete|}('${2:/path}', (req, res) => {
      $3
    });
  ]]></content>
  <tabTrigger>route</tabTrigger>
  <scope>source.js</scope>
</snippet>
```

## Best Practices

### Snippet Creation

1. **Descriptive Triggers**: Use clear trigger names
2. **Tab Stops**: Use logical tab stop order
3. **Default Values**: Provide helpful defaults
4. **Documentation**: Add descriptions

### Organization

1. **Language-Specific**: Organize by language
2. **Naming Conventions**: Use consistent naming
3. **Version Control**: Track snippets in Git
4. **Share Snippets**: Share with team

## Next Steps

- Configure [Key Bindings](./SUBLIME-KEY-BINDINGS.md)
- Explore [Projects](./SUBLIME-PROJECTS.md)
- Optimize [Performance](./SUBLIME-PERFORMANCE.md)

Snippets boost productivity. Create custom snippets for your common patterns.





