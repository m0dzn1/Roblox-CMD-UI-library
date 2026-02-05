# Contributing to CMD UI Library

Thank you for your interest in contributing to CMD UI Library! We welcome contributions from the community.

## How to Contribute

### Reporting Bugs

If you find a bug, please create an issue with:
- A clear, descriptive title
- Steps to reproduce the bug
- Expected behavior vs actual behavior
- Roblox Studio version
- Any error messages or screenshots

### Suggesting Features

We love feature suggestions! Please create an issue with:
- A clear description of the feature
- Why it would be useful
- Example use cases
- Optional: mockups or code examples

### Code Contributions

1. **Fork the repository**
2. **Create a new branch** for your feature
   ```bash
   git checkout -b feature/your-feature-name
   ```
3. **Make your changes** following our coding standards
4. **Test thoroughly** in Roblox Studio
5. **Commit your changes**
   ```bash
   git commit -m "Add: description of your changes"
   ```
6. **Push to your fork**
   ```bash
   git push origin feature/your-feature-name
   ```
7. **Create a Pull Request** with a clear description

## Coding Standards

### Luau Style Guide

- Use **camelCase** for variables and functions
- Use **PascalCase** for classes and modules
- Use **UPPER_CASE** for constants
- Indent with **tabs** (4 spaces)
- Add comments for complex logic
- Keep functions focused and under 50 lines when possible

### Example:

```lua
-- Good
local function calculateTotal(items)
    local total = 0
    for _, item in ipairs(items) do
        total = total + item.price
    end
    return total
end

-- Bad
local function calc(i)
    local t=0
    for _,x in ipairs(i) do t=t+x.price end
    return t
end
```

### Documentation

- Add comments explaining **why**, not **what**
- Document all public functions
- Include usage examples for new features
- Update README.md if adding new API methods

## Testing

Before submitting a PR:
- [ ] Test in Roblox Studio
- [ ] Test with multiple instances of the UI
- [ ] Test all input methods (SelectByNumber, Confirm, Input)
- [ ] Test error handling
- [ ] Check for memory leaks (proper cleanup)
- [ ] Verify boot sequence timing

## Pull Request Guidelines

### PR Title Format:
- `Add: [feature description]` - New features
- `Fix: [bug description]` - Bug fixes
- `Update: [what changed]` - Updates to existing features
- `Docs: [documentation changes]` - Documentation only

### PR Description Should Include:
- What changes were made
- Why the changes were necessary
- How to test the changes
- Screenshots/GIFs if UI changes
- Any breaking changes

## Feature Priorities

### High Priority
- Bug fixes
- Performance improvements
- Documentation improvements
- Accessibility features

### Medium Priority
- New input methods
- UI customization options
- Quality of life improvements

### Low Priority
- Major architectural changes
- Experimental features

## Code Review Process

1. Maintainers will review your PR
2. You may be asked to make changes
3. Once approved, your PR will be merged
4. You'll be credited in the CHANGELOG

## Questions?

Feel free to:
- Open an issue for discussion
- Ask questions in pull requests
- Reach out to m0dzn

## License

By contributing, you agree that your contributions will be licensed under the MIT License.

---

**Thank you for contributing to CMD UI Library!** 🎉
