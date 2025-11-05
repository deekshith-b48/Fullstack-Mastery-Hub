# WebStorm Refactoring

Refactoring is the process of restructuring code without changing its behavior. WebStorm provides powerful refactoring tools to safely transform code.

## Refactoring Overview

WebStorm refactoring features:
- **Safe Transformations**: Automatic safety checks
- **Project-Wide Changes**: Update all references
- **Preview Changes**: Review before applying
- **Undo Support**: Easy undo if needed

## Accessing Refactoring

### Refactor Menu

- **Right-click**: Context menu → Refactor
- **Menu Bar**: Refactor menu
- **Keyboard**: `Ctrl+Alt+Shift+T` / `Cmd+Ctrl+Shift+T`
- **Quick Actions**: `Alt+Enter` / `Option+Enter`

## Common Refactorings

### Rename

Rename symbols safely:

1. Select symbol
2. `Shift+F6` / `Shift+F6`
3. Enter new name
4. Preview changes
5. Refactor

**Features:**
- Rename across project
- Update all references
- Preview changes
- Search in comments/strings option

### Extract

Extract code into separate entities:

#### Extract Variable

1. Select expression
2. `Ctrl+Alt+V` / `Cmd+Option+V`
3. Choose name
4. Select scope
5. Extract

#### Extract Method

1. Select code block
2. `Ctrl+Alt+M` / `Cmd+Option+M`
3. Configure method
4. Extract

#### Extract Constant

1. Select value
2. `Ctrl+Alt+C` / `Cmd+Option+C`
3. Choose name
4. Extract

#### Extract Component (React)

1. Select JSX
2. Refactor → Extract Component
3. Configure component
4. Extract

### Inline

Inline variables, methods, constants:

1. Place cursor on symbol
2. `Ctrl+Alt+N` / `Cmd+Option+N`
3. Preview changes
4. Inline

### Move

Move classes, methods, files:

1. Select element
2. `F6` / `F6`
3. Choose destination
4. Move

### Change Signature

Modify function signatures:

1. Place cursor on function
2. `Ctrl+F6` / `Cmd+F6`
3. Modify parameters
4. Preview changes
5. Refactor

## Code Transformations

### Convert to Arrow Function

1. Select function
2. `Alt+Enter` → Convert to arrow function
3. Apply

### Convert to Template String

1. Select string concatenation
2. `Alt+Enter` → Convert to template string
3. Apply

### Convert to Destructuring

1. Select variable assignment
2. `Alt+Enter` → Convert to destructuring
3. Apply

### Convert to For-Each

1. Select for loop
2. `Alt+Enter` → Convert to for-each
3. Apply

## Safe Delete

Delete unused code:

1. Select code
2. `Alt+Delete` / `Cmd+Delete`
3. Preview usages
4. Safe delete

## Refactoring Options

### Preview Changes

Always preview changes:
- Review modifications
- Check affected files
- Verify transformations

### Search in Comments/Strings

Options when refactoring:
- Search in comments
- Search in strings
- Update references

### Scope Selection

Choose refactoring scope:
- Current file
- Project files
- Module
- Custom scope

## Advanced Refactorings

### Extract Interface

Extract interface from class:

1. Select class
2. Refactor → Extract Interface
3. Configure interface
4. Extract

### Extract Superclass

Extract common functionality:

1. Select class
2. Refactor → Extract Superclass
3. Configure superclass
4. Extract

### Pull Members Up

Move members to superclass:

1. Select members
2. Refactor → Pull Members Up
3. Choose superclass
4. Pull up

### Push Members Down

Move members to subclass:

1. Select members
2. Refactor → Push Members Down
3. Choose subclass
4. Push down

## React Refactorings

### Extract Component

Extract React component:

1. Select JSX
2. Refactor → Extract Component
3. Configure component
4. Extract

### Convert to Functional Component

Convert class to function:

1. Select class component
2. Refactor → Convert to Functional Component
3. Apply

### Extract Hook

Extract custom hook:

1. Select hook logic
2. Refactor → Extract Hook
3. Configure hook
4. Extract

## TypeScript Refactorings

### Extract Type

Extract type definition:

1. Select type usage
2. Refactor → Extract Type
3. Configure type
4. Extract

### Extract Interface

Extract interface:

1. Select interface usage
2. Refactor → Extract Interface
3. Configure interface
4. Extract

## Best Practices

### Refactoring Safely

1. **Use Version Control**: Commit before refactoring
2. **Preview Changes**: Always review changes
3. **Test After**: Run tests after refactoring
4. **Incremental**: Refactor in small steps
5. **Document**: Document complex refactorings

### When to Refactor

- **Code Duplication**: Remove duplicate code
- **Complex Methods**: Break down complex methods
- **Naming**: Improve naming clarity
- **Structure**: Improve code structure
- **Performance**: Optimize code

## Troubleshooting

### Refactoring Issues

- **Conflicts**: Resolve merge conflicts
- **Errors**: Fix compilation errors
- **Undo**: Use undo if needed
- **Preview**: Always preview changes

## Next Steps

- Learn [Debugging](./WEBSTORM-DEBUGGING.md)
- Configure [Version Control](./WEBSTORM-VERSION-CONTROL.md)
- Explore [Database Tools](./WEBSTORM-DATABASE-TOOLS.md)

Refactoring improves code quality and maintainability. Use WebStorm's refactoring tools to safely transform your code.


