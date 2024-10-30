<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->

# Filter Text Package

This package provides a set of utilities to filter sensitive or unwanted text content based on various criteria. It can be particularly useful for applications that require moderation of user-generated content, such as chat applications, forums, or social media platforms.

## Features

- Filters sensitive words and phrases, including but not limited to:
    - Explicit or adult-themed content
    - Political content
    - Profanity
    - Hate speech
    - Violent content
    - Drug references
    - Spam content
    - Personal information
    - Racial slurs
    - Long and short words
    - Emojis and unsupported text

- Easy-to-use API for quick integration into existing projects.

## Getting started

### Prerequisites

- Dart SDK version >=2.12.0
- Flutter SDK (if using with Flutter)

### Installation

Add the following line to your `pubspec.yaml`:

```yaml
dependencies:
  filter_text: ^1.0.0
