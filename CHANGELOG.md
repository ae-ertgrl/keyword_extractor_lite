## 1.0.0

- Initial release of keyword_extractor_lite
- **Core Features:**
  - `KeywordExtractor.extract()` - Extract top N keywords from text
  - `KeywordExtractor.extractWithFrequency()` - Extract keywords with their frequency counts
- **Optimizations:**
  - Turkish language optimization with comprehensive stop-words list
  - Preserves Turkish characters (ğ, ü, ş, ı, ö, ç)
  - Filters words shorter than 3 characters
  - Efficient frequency-based algorithm
- **Platform Support:**
  - Pure Dart implementation (no Flutter dependency)
  - Works on Backend, Client, CLI, and Web
- **Zero Dependencies:**
  - Lightweight package with no external dependencies
  - High performance with minimal footprint
