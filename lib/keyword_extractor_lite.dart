/// A lightweight, zero-dependency Dart package for extracting frequent keywords from text.
///
/// This package provides a simple API to extract the most frequent keywords from
/// any given text. It's optimized for Turkish language but can be extended to
/// support other languages.
///
/// ## Features
///
/// - **Lightweight**: No external dependencies
/// - **Fast**: Efficient frequency-based algorithm
/// - **Easy to use**: Simple, intuitive API
/// - **Platform agnostic**: Works on Backend, Client, CLI, and Web
///
/// ## Usage
///
/// ```dart
/// import 'package:keyword_extractor_lite/keyword_extractor_lite.dart';
///
/// void main() {
///   final text = '''
///     Flutter ve Dart ile mobil uygulama geliştirmek çok kolay.
///     Flutter cross-platform uygulama geliştirme için harika bir framework.
///   ''';
///
///   final keywords = KeywordExtractor.extract(text);
///   print(keywords); // [flutter, dart, uygulama, geliştirme, ...]
/// }
/// ```
library;

export 'src/keyword_extractor.dart';
