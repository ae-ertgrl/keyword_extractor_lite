# keyword_extractor_lite

[![Pub Version](https://img.shields.io/pub/v/keyword_extractor_lite)](https://pub.dev/packages/keyword_extractor_lite)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

A **lightweight**, **zero-dependency** Dart package for extracting the most frequent keywords from text. Perfect for auto-tagging, SEO analysis, content categorization, and more.

## ✨ Features

- **🚀 Lightweight & Fast** - Minimal footprint with high performance
- **📦 Zero Dependencies** - Pure Dart implementation
- **🔧 Easy to Use** - Simple, intuitive API
- **🌐 Platform Agnostic** - Works on Backend (Serverpod), Client, CLI, and Web
- **🇹🇷 Turkish Optimized** - Built-in Turkish stop-words (extensible for other languages)

## 📋 Use Cases

- **Auto-tagging** in SaaS applications
- **SEO keyword analysis** for content optimization
- **Content categorization** and classification
- **Tag extraction** from user-generated content
- **Text summarization** and topic detection

## 🚀 Getting Started

Add `keyword_extractor_lite` to your `pubspec.yaml`:

```yaml
dependencies:
  keyword_extractor_lite: ^1.0.0
```

Then run:

```bash
dart pub get
```

## 💡 Usage

### Basic Example

```dart
import 'package:keyword_extractor_lite/keyword_extractor_lite.dart';

void main() {
  final text = '''
    Flutter and Dart make mobile app development easy. 
    Flutter is a great framework for cross-platform app development. 
    Dart is a modern and powerful programming language.
  ''';

  // Extract top 5 keywords (default)
  final keywords = KeywordExtractor.extract(text);
  print(keywords); // Output: [flutter, dart, app, development, language]
}
```

### Custom Limit

```dart
import 'package:keyword_extractor_lite/keyword_extractor_lite.dart';

void main() {
  final text = '''
    Artificial intelligence technologies are developing rapidly. Machine learning 
    and deep learning play an important role in the field of artificial intelligence.
  ''';

  // Extract top 3 keywords
  final keywords = KeywordExtractor.extract(text, limit: 3);
  print(keywords); // Output: [artificial, intelligence, learning]
}
```

### Real-World Example: Auto-Tagging Blog Posts

```dart
import 'package:keyword_extractor_lite/keyword_extractor_lite.dart';

class BlogPost {
  final String title;
  final String content;
  List<String> tags = [];

  BlogPost(this.title, this.content);

  void generateTags() {
    final combinedText = '$title $content';
    tags = KeywordExtractor.extract(combinedText, limit: 5);
  }
}

void main() {
  final post = BlogPost(
    'Mobile App Development with Flutter',
    '''
      Flutter is an open-source UI framework developed by Google.
      You can develop native applications for iOS and Android using the Dart 
      programming language. The development process is very fast and efficient 
      thanks to the hot reload feature.
    ''',
  );

  post.generateTags();
  print('Generated Tags: ${post.tags}');
  // Output: Generated Tags: [flutter, dart, app, development, native]
}
```

## 🔧 API Reference

### `KeywordExtractor.extract()`

Extracts the most frequent keywords from the given text.

**Parameters:**
- `text` (String, required) - The input text to extract keywords from
- `limit` (int, optional) - Maximum number of keywords to return (default: 5)

**Returns:**
- `List<String>` - A list of extracted keywords, ordered by frequency (most frequent first)

**How it works:**
1. Converts text to lowercase
2. Removes special characters (preserves Turkish characters: ğ, ü, ş, ı, ö, ç)
3. Filters out stop-words (common Turkish words like "ve", "ile", "bir", etc.)
4. Filters out words shorter than 3 characters
5. Calculates word frequency
6. Returns the top N most frequent words

### `KeywordExtractor.extractWithFrequency()`

Extracts keywords with their frequency counts.

**Parameters:**
- `text` (String, required) - The input text to extract keywords from
- `limit` (int, optional) - Maximum number of keywords to return (default: 5)

**Returns:**
- `Map<String, int>` - A map where keys are keywords and values are their frequencies

**Example:**
```dart
final text = 'Flutter Flutter Flutter Dart Dart app';
final keywords = KeywordExtractor.extractWithFrequency(text, limit: 3);
print(keywords); // {flutter: 3, dart: 2, app: 1}
```

## 🌍 Language Support

Currently optimized for **Turkish** with built-in Turkish stop-words. The package can be easily extended to support other languages by modifying the stop-words set.

**Built-in Turkish stop-words:**
`ve`, `ile`, `ama`, `fakat`, `için`, `bir`, `bu`, `şu`, `o`, `da`, `de`, `mi`, `mı`, `mu`, `mü`, `ki`, `ne`, `ya`, `veya`, `çok`, `daha`, `en`, `gibi`, `kadar`, `her`, `ben`, `sen`, `biz`, `siz`, `onlar`

## 🎯 Performance

- **Lightweight**: No external dependencies
- **Fast**: Efficient frequency-based algorithm
- **Memory-efficient**: Processes text in a single pass
- **Benchmark**: 1ms for 3,970 characters (464 words)

## 📝 Example Output

```dart
final text = 'Serverpod is an excellent framework for backend development. '
             'Developing APIs with Serverpod is very easy.';

final keywords = KeywordExtractor.extract(text, limit: 3);
print(keywords); // [serverpod, development, backend]
```

## 🛠️ Advanced Usage

### Serverpod Backend Integration

```dart
import 'package:keyword_extractor_lite/keyword_extractor_lite.dart';
import 'package:serverpod/serverpod.dart';

class ArticleEndpoint extends Endpoint {
  Future<List<String>> generateArticleTags(
    Session session,
    String articleContent,
  ) async {
    // Generate automatic tags from article
    final tags = KeywordExtractor.extract(
      articleContent,
      limit: 10,
    );
    
    return tags;
  }
}
```

### Flutter Application Usage

```dart
import 'package:flutter/material.dart';
import 'package:keyword_extractor_lite/keyword_extractor_lite.dart';

class TagGenerator extends StatefulWidget {
  @override
  _TagGeneratorState createState() => _TagGeneratorState();
}

class _TagGeneratorState extends State<TagGenerator> {
  final TextEditingController _controller = TextEditingController();
  List<String> _tags = [];

  void _generateTags() {
    setState(() {
      _tags = KeywordExtractor.extract(_controller.text, limit: 8);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _controller,
          decoration: InputDecoration(labelText: 'Enter your text'),
          maxLines: 5,
        ),
        ElevatedButton(
          onPressed: _generateTags,
          child: Text('Generate Tags'),
        ),
        Wrap(
          spacing: 8,
          children: _tags
              .map((tag) => Chip(label: Text(tag)))
              .toList(),
        ),
      ],
    );
  }
}
```

### E-Commerce Product Tagging

```dart
import 'package:keyword_extractor_lite/keyword_extractor_lite.dart';

class ProductDescription {
  final String title;
  final String description;
  
  ProductDescription(this.title, this.description);
  
  List<String> autoTags() {
    final fullText = '$title $description';
    return KeywordExtractor.extract(fullText, limit: 8);
  }
}

void main() {
  final product = ProductDescription(
    'Professional Camera',
    '''
      High-resolution sensor and advanced image processing technology for 
      professional photography experience. 4K video recording, optical image 
      stabilization, and wide dynamic range features.
    ''',
  );

  final tags = product.autoTags();
  print('Auto Tags: $tags');
  // Output: [professional, camera, image, video, recording, technology, ...]
}
```

## 🤝 Contributing

Contributions are welcome! If you'd like to add support for additional languages or improve the algorithm, please feel free to open an issue or submit a pull request.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

Created with ❤️ for the Dart and Flutter community.

**Developer:** Abdurrahman Ertuğrul

---

**Found this package helpful?** Give it a ⭐ on [GitHub](https://github.com/ae-ertgrl/keyword_extractor_lite)!
