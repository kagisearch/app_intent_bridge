# Contributing to `app_intent_bridge`

This guide covers how to contribute to app_intent_bridge. See the [README](README.md) for a project overview before getting started.

## Getting Started

### Prerequisites

- Flutter SDK 3.41.0+
- Dart SDK 3.10.8+
- Xcode (for iOS development)
- CocoaPods

### Building the Project

```
flutter pub get
```

To build the example app:

```
cd example && flutter build ios
```

### Running Tests

```
flutter test
```

## How to Contribute

### Report Bugs

Found something broken? Use the **Bug Report** issue template and include clear steps to reproduce the problem. The more detail you include, the faster we can investigate.

### Suggest Features

Open a feature request using the **Feature Request** issue template. Describe the problem you're trying to solve, not just the solution you have in mind -- understanding the use case helps us figure out the best approach.

### Submit Code Changes

1. **Fork** the repository.
2. **Create a feature branch** from `main`:
   ```
   git checkout -b your-feature
   ```
3. **Make your changes.** Try to keep each commit focused on a single logical change.
4. **Add or update tests** as appropriate to cover your changes.
5. **Ensure all tests pass** locally before pushing.
6. **Submit a pull request** back to this repository.

## Code Standards

- We use `flutter_lints` for static analysis (configured in `analysis_options.yaml`).
- Run `flutter analyze` before submitting to catch issues early.
- Run `dart format .` to format code consistently.

## Pull Request Process

- **Reference related issues** when applicable (e.g., "Fixes #123").
- **Describe what your PR does** and explain how reviewers can test it.
- **Keep PRs focused** -- one logical change per pull request.
- **All CI checks must pass** before a PR can be merged.
- A maintainer will review your PR. We aim to respond within a few business days.

## Communication

Open a [GitHub Issue](../../issues) or start a [GitHub Discussion](../../discussions).
