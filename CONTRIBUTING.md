# Contributing to Flutter BLoC Boilerplate

First off, thank you for considering contributing to Flutter BLoC Boilerplate! 🎉

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [How Can I Contribute?](#how-can-i-contribute)
- [Development Setup](#development-setup)
- [Pull Request Process](#pull-request-process)
- [Style Guidelines](#style-guidelines)

## Code of Conduct

This project and everyone participating in it is governed by our Code of Conduct. By participating, you are expected to uphold this code. Please report unacceptable behavior to the repository maintainers.

## How Can I Contribute?

### Reporting Bugs

Before creating bug reports, please check existing issues to avoid duplicates. When creating a bug report, include:

- **Clear title and description**
- **Steps to reproduce** the problem
- **Expected behavior**
- **Actual behavior**
- **Screenshots** (if applicable)
- **Environment details** (Flutter version, OS, device)

### Suggesting Enhancements

Enhancement suggestions are tracked as GitHub issues. When creating an enhancement suggestion, include:

- **Clear title and description**
- **Use case** - why would this be useful?
- **Proposed solution** (if you have one)
- **Alternative solutions** you've considered

### Pull Requests

1. **Fork the repository** and create your branch from `main`
2. **Make your changes** following our style guidelines
3. **Test your changes** thoroughly
4. **Update documentation** if needed
5. **Commit your changes** with clear commit messages
6. **Push to your fork** and submit a pull request

## Development Setup

1. **Clone your fork**
   ```bash
   git clone https://github.com/YOUR_USERNAME/flutter-boiler-plate.git
   cd flutter-boiler-plate
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the setup script** (to test it)
   ```bash
   dart run tool/setup.dart --dry-run
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

## Pull Request Process

1. **Update documentation** for any changes to functionality
2. **Update CHANGELOG.md** with your changes
3. **Ensure the codebase analyzes** without errors:
   ```bash
   flutter analyze
   ```
4. **Format your code**:
   ```bash
   flutter format .
   ```
5. **Test on both platforms** (if applicable)
6. Your PR will be reviewed by maintainers

## Style Guidelines

### Dart/Flutter Code Style

- Follow the [official Dart style guide](https://dart.dev/guides/language/effective-dart/style)
- Use `flutter format` to format code
- Maximum line length: 80 characters (where reasonable)
- Use meaningful variable and function names

### Commit Messages

- Use present tense ("Add feature" not "Added feature")
- Use imperative mood ("Move cursor to..." not "Moves cursor to...")
- Start with a capital letter
- Keep first line under 50 characters
- Reference issues and PRs when applicable

**Examples:**
```
Add password validation to login screen
Fix navigation bug in dashboard
Update README with new setup instructions
```

### Branch Naming

- `feature/description` - for new features
- `fix/description` - for bug fixes
- `docs/description` - for documentation
- `refactor/description` - for refactoring

**Examples:**
```
feature/add-profile-screen
fix/login-validation-error
docs/update-setup-guide
```

## Project Structure Guidelines

When adding new features:

1. **Follow the existing structure**:
   ```
   lib/presentation/your_screen/
   ├── bloc/
   ├── models/
   ├── widgets/ (optional)
   └── your_screen.dart
   ```

2. **Use BLoC pattern** for state management
3. **Keep screens focused** - one responsibility per screen
4. **Reuse widgets** from the widgets directory
5. **Update routes** in `lib/routes/app_routes.dart`

## What to Contribute

We're always looking for contributions in these areas:

- 🐛 **Bug fixes**
- 📝 **Documentation improvements**
- ✨ **New reusable widgets**
- 🎨 **UI/UX improvements**
- 🧪 **Tests** (widget tests, unit tests)
- 🌍 **Translations**
- 📱 **Platform-specific improvements**

## Questions?

Feel free to open an issue with the `question` label if you need clarification on anything.

---

Thank you for contributing! 🚀

