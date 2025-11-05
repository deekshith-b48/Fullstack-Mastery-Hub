# Pull Request Templates

Pull request templates standardize PR descriptions and ensure important information is included. This guide covers creating and using PR templates.

## PR Template Overview

PR templates provide:
- **Consistency**: Consistent PR descriptions
- **Completeness**: Ensure all info included
- **Guidance**: Guide authors on what to include
- **Efficiency**: Faster review process

## Template Structure

### Basic Template

```markdown
## Description
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation update

## Testing
- [ ] Tests added/updated
- [ ] All tests pass
- [ ] Manual testing completed

## Checklist
- [ ] Code follows style guidelines
- [ ] Self-review completed
- [ ] Comments added for complex code
- [ ] Documentation updated
```

## Template Sections

### Description

- **What**: What changes were made
- **Why**: Why these changes were made
- **How**: How the changes work
- **Impact**: Impact of changes

### Type of Change

- **Bug Fix**: Fixes a bug
- **Feature**: New feature
- **Refactoring**: Code refactoring
- **Documentation**: Documentation update
- **Performance**: Performance improvement

### Testing

- **Unit Tests**: Unit tests added/updated
- **Integration Tests**: Integration tests
- **Manual Testing**: Manual testing done
- **Test Results**: Test results included

### Checklist

- **Code Quality**: Code quality checks
- **Documentation**: Documentation updated
- **Review**: Self-review done
- **Standards**: Follows standards

## GitHub Templates

### Creating Template

1. Create `.github/pull_request_template.md`
2. Add template content
3. Commit to repository
4. Template appears automatically

### Template Location

```
.github/
  pull_request_template.md
```

### Multiple Templates

Create multiple templates:
```
.github/
  pull_request_template.md (default)
  .github/
    PULL_REQUEST_TEMPLATE/
      bug_fix.md
      feature.md
      documentation.md
```

## Template Examples

### Feature Template

```markdown
## Feature Description
Describe the feature

## User Story
As a [user type], I want [goal] so that [benefit]

## Changes Made
- Change 1
- Change 2
- Change 3

## Screenshots
[If applicable]

## Testing
- [ ] Unit tests
- [ ] Integration tests
- [ ] Manual testing

## Checklist
- [ ] Code reviewed
- [ ] Tests pass
- [ ] Documentation updated
```

### Bug Fix Template

```markdown
## Bug Description
Describe the bug

## Steps to Reproduce
1. Step 1
2. Step 2
3. Step 3

## Expected Behavior
What should happen

## Actual Behavior
What actually happens

## Fix Description
How the bug was fixed

## Testing
- [ ] Bug verified fixed
- [ ] Regression tests added
- [ ] All tests pass
```

## Best Practices

### Template Design

1. **Keep Simple**: Don't over-complicate
2. **Relevant**: Include relevant sections
3. **Optional Fields**: Mark optional fields
4. **Examples**: Provide examples
5. **Update Regularly**: Update as needed

### Usage

1. **Fill Completely**: Fill all relevant sections
2. **Be Specific**: Be specific in descriptions
3. **Include Context**: Include necessary context
4. **Review**: Review before submitting

## Next Steps

- Explore [Code Review Tools](./CODE-REVIEW-TOOLS.md)
- Learn [Effective Feedback](./EFFECTIVE-FEEDBACK.md)
- Study [Code Review Metrics](./CODE-REVIEW-METRICS.md)

PR templates improve review efficiency. Use templates to standardize your PR process.





