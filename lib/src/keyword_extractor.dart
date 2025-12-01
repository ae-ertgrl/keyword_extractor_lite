/// A class that extracts the most frequent keywords from text.
///
/// This class provides a static method [extract] that analyzes text and returns
/// the most frequently occurring keywords after filtering out stop-words and
/// short words.
class KeywordExtractor {
  /// Turkish stop-words that will be filtered out during extraction.
  ///
  /// These are common words that don't carry significant meaning for
  /// keyword extraction purposes.
  static const Set<String> _stopWordsTR = {
    've',
    'ile',
    'ama',
    'fakat',
    'için',
    'bir',
    'bu',
    'şu',
    'o',
    'da',
    'de',
    'mi',
    'mı',
    'mu',
    'mü',
    'ki',
    'ne',
    'ya',
    'veya',
    'çok',
    'daha',
    'en',
    'gibi',
    'kadar',
    'her',
    'ben',
    'sen',
    'biz',
    'siz',
    'onlar',
  };

  /// Minimum word length to be considered as a keyword.
  static const int _minWordLength = 3;

  /// Extracts the most frequent keywords from the given [text].
  ///
  /// The extraction process:
  /// 1. Converts text to lowercase
  /// 2. Removes special characters (preserves Turkish characters: ğ, ü, ş, ı, ö, ç)
  /// 3. Filters out stop-words
  /// 4. Filters out words shorter than 3 characters
  /// 5. Calculates word frequency
  /// 6. Returns the top N most frequent words
  ///
  /// Parameters:
  /// - [text]: The input text to extract keywords from
  /// - [limit]: Maximum number of keywords to return (default: 5)
  ///
  /// Returns a list of keywords ordered by frequency (most frequent first).
  ///
  /// Example:
  /// ```dart
  /// final text = 'Flutter ve Dart ile mobil uygulama geliştirmek kolay.';
  /// final keywords = KeywordExtractor.extract(text, limit: 3);
  /// print(keywords); // [flutter, dart, uygulama]
  /// ```
  static List<String> extract(String text, {int limit = 5}) {
    if (text.isEmpty) return [];
    if (limit <= 0) return [];

    // Convert to lowercase and clean special characters
    // Preserve Turkish characters: ğ, ü, ş, ı, ö, ç
    final cleanText = text.toLowerCase().replaceAll(
      RegExp(r'[^\w\sğüşıöç]'),
      '',
    );

    // Split into words
    final words = cleanText.split(RegExp(r'\s+'));

    // Calculate frequency
    final frequencyMap = <String, int>{};

    for (final word in words) {
      // Skip short words and stop-words
      if (word.length < _minWordLength || _stopWordsTR.contains(word)) {
        continue;
      }

      frequencyMap[word] = (frequencyMap[word] ?? 0) + 1;
    }

    // Sort by frequency (descending)
    final sortedEntries = frequencyMap.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    // Return top N keywords
    return sortedEntries.take(limit).map((e) => e.key).toList();
  }

  /// Extracts keywords with their frequency counts.
  ///
  /// Similar to [extract] but returns a map of keywords to their occurrence counts.
  ///
  /// Parameters:
  /// - [text]: The input text to extract keywords from
  /// - [limit]: Maximum number of keywords to return (default: 5)
  ///
  /// Returns a map where keys are keywords and values are their frequencies.
  ///
  /// Example:
  /// ```dart
  /// final text = 'Flutter Flutter Dart Dart Dart uygulama';
  /// final keywords = KeywordExtractor.extractWithFrequency(text, limit: 3);
  /// print(keywords); // {dart: 3, flutter: 2, uygulama: 1}
  /// ```
  static Map<String, int> extractWithFrequency(String text, {int limit = 5}) {
    if (text.isEmpty) return {};
    if (limit <= 0) return {};

    final cleanText = text.toLowerCase().replaceAll(
      RegExp(r'[^\w\sğüşıöç]'),
      '',
    );

    final words = cleanText.split(RegExp(r'\s+'));
    final frequencyMap = <String, int>{};

    for (final word in words) {
      if (word.length < _minWordLength || _stopWordsTR.contains(word)) {
        continue;
      }

      frequencyMap[word] = (frequencyMap[word] ?? 0) + 1;
    }

    final sortedEntries = frequencyMap.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return Map.fromEntries(sortedEntries.take(limit));
  }
}
