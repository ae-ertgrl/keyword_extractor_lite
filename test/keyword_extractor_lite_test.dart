import 'package:keyword_extractor_lite/keyword_extractor_lite.dart';
import 'package:test/test.dart';

void main() {
  group('KeywordExtractor.extract', () {
    test('extracts keywords from Turkish text', () {
      final text = '''
        Flutter ve Dart ile mobil uygulama geliştirmek çok kolay. 
        Flutter cross-platform uygulama geliştirme için harika bir framework.
      ''';

      final keywords = KeywordExtractor.extract(text, limit: 5);

      expect(keywords, isNotEmpty);
      expect(keywords.length, lessThanOrEqualTo(5));
      expect(keywords, contains('flutter'));
      expect(keywords, contains('dart'));
      expect(keywords, contains('uygulama'));
    });

    test('filters out stop-words', () {
      final text = 'Flutter ve Dart ile bir uygulama';

      final keywords = KeywordExtractor.extract(text);

      expect(keywords, isNot(contains('ve')));
      expect(keywords, isNot(contains('ile')));
      expect(keywords, isNot(contains('bir')));
    });

    test('filters out short words (less than 3 characters)', () {
      final text = 'Flutter ve Dart de mi';

      final keywords = KeywordExtractor.extract(text);

      expect(keywords, isNot(contains('ve')));
      expect(keywords, isNot(contains('de')));
      expect(keywords, isNot(contains('mi')));
    });

    test('returns keywords ordered by frequency', () {
      final text = '''
        Flutter Flutter Flutter Dart Dart uygulama
      ''';

      final keywords = KeywordExtractor.extract(text, limit: 3);

      expect(keywords[0], equals('flutter'));
      expect(keywords[1], equals('dart'));
      expect(keywords[2], equals('uygulama'));
    });

    test('respects the limit parameter', () {
      final text = '''
        Flutter Dart uygulama geliştirme framework platform kod test
      ''';

      final keywords = KeywordExtractor.extract(text, limit: 3);

      expect(keywords.length, equals(3));
    });

    test('handles empty text', () {
      final keywords = KeywordExtractor.extract('');

      expect(keywords, isEmpty);
    });

    test('handles text with only stop-words', () {
      final text = 've ile ama fakat için bir bu';

      final keywords = KeywordExtractor.extract(text);

      expect(keywords, isEmpty);
    });

    test('handles text with special characters', () {
      final text = 'Flutter! Dart? uygulama. geliştirme, framework;';

      final keywords = KeywordExtractor.extract(text);

      expect(keywords, contains('flutter'));
      expect(keywords, contains('dart'));
      expect(keywords, contains('uygulama'));
    });

    test('preserves Turkish characters', () {
      final text = 'çalışma güvenlik şifreleme ışık öğrenme ülke';

      final keywords = KeywordExtractor.extract(text);

      expect(keywords, contains('çalışma'));
      expect(keywords, contains('güvenlik'));
      expect(keywords, contains('şifreleme'));
      expect(keywords, contains('öğrenme'));
    });

    test('handles zero or negative limit', () {
      final text = 'Flutter Dart uygulama';

      final keywords1 = KeywordExtractor.extract(text, limit: 0);
      final keywords2 = KeywordExtractor.extract(text, limit: -5);

      expect(keywords1, isEmpty);
      expect(keywords2, isEmpty);
    });

    test('handles real-world blog post example', () {
      final text = '''
        Serverpod backend geliştirme için mükemmel bir framework. 
        Serverpod ile API geliştirmek çok kolay ve hızlı.
        Backend geliştirme artık daha verimli.
      ''';

      final keywords = KeywordExtractor.extract(text, limit: 5);

      expect(keywords, contains('serverpod'));
      expect(keywords, contains('geliştirme'));
      expect(keywords, contains('backend'));
    });
  });

  group('KeywordExtractor.extractWithFrequency', () {
    test('returns keywords with their frequencies', () {
      final text = 'Flutter Flutter Flutter Dart Dart uygulama';

      final result = KeywordExtractor.extractWithFrequency(text, limit: 3);

      expect(result['flutter'], equals(3));
      expect(result['dart'], equals(2));
      expect(result['uygulama'], equals(1));
    });

    test('respects the limit parameter', () {
      final text = 'Flutter Dart uygulama geliştirme framework';

      final result = KeywordExtractor.extractWithFrequency(text, limit: 2);

      expect(result.length, equals(2));
    });

    test('handles empty text', () {
      final result = KeywordExtractor.extractWithFrequency('');

      expect(result, isEmpty);
    });

    test('returns map ordered by frequency', () {
      final text = 'aaa aaa aaa bbb bbb ccc';

      final result = KeywordExtractor.extractWithFrequency(text, limit: 3);
      final keys = result.keys.toList();

      expect(keys[0], equals('aaa'));
      expect(keys[1], equals('bbb'));
      expect(keys[2], equals('ccc'));
    });

    test('handles zero or negative limit', () {
      final text = 'Flutter Dart uygulama';

      final result1 = KeywordExtractor.extractWithFrequency(text, limit: 0);
      final result2 = KeywordExtractor.extractWithFrequency(text, limit: -5);

      expect(result1, isEmpty);
      expect(result2, isEmpty);
    });
  });
}
