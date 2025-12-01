import 'package:keyword_extractor_lite/keyword_extractor_lite.dart';

void main() {
  print('=== Keyword Extractor Lite - Examples ===\n');

  // Example 1: Basic Usage
  print('Example 1: Basic Usage');
  final text1 = '''
    Flutter ve Dart ile mobil uygulama geliştirmek çok kolay. 
    Flutter cross-platform uygulama geliştirme için harika bir framework. 
    Dart dili modern ve güçlü bir programlama dilidir.
  ''';

  final keywords1 = KeywordExtractor.extract(text1);
  print('Text: ${text1.replaceAll('\n', ' ').trim()}');
  print('Keywords: $keywords1');
  print('');

  // Example 2: Custom Limit
  print('Example 2: Custom Limit (3 keywords)');
  final text2 = '''
    Yapay zeka teknolojileri hızla gelişiyor. Makine öğrenmesi ve 
    derin öğrenme yapay zeka alanında önemli rol oynuyor.
  ''';

  final keywords2 = KeywordExtractor.extract(text2, limit: 3);
  print('Text: ${text2.replaceAll('\n', ' ').trim()}');
  print('Keywords: $keywords2');
  print('');

  // Example 3: Blog Post Auto-Tagging
  print('Example 3: Blog Post Auto-Tagging');
  final blogPost = BlogPost('Flutter ile Mobil Uygulama Geliştirme', '''
      Flutter, Google tarafından geliştirilen açık kaynaklı bir UI framework'tür.
      Dart programlama dili kullanarak iOS ve Android için native uygulamalar 
      geliştirebilirsiniz. Hot reload özelliği sayesinde geliştirme süreci 
      oldukça hızlı ve verimlidir.
    ''');

  blogPost.generateTags();
  print('Blog Title: ${blogPost.title}');
  print('Generated Tags: ${blogPost.tags}');
  print('');

  // Example 4: Extract with Frequency
  print('Example 4: Extract with Frequency');
  final text4 = '''
    Serverpod backend geliştirme için mükemmel bir framework. 
    Serverpod ile API geliştirmek çok kolay. Backend geliştirme 
    artık daha verimli.
  ''';

  final keywordsWithFreq = KeywordExtractor.extractWithFrequency(
    text4,
    limit: 5,
  );
  print('Text: ${text4.replaceAll('\n', ' ').trim()}');
  print('Keywords with Frequency:');
  keywordsWithFreq.forEach((keyword, frequency) {
    print('  - $keyword: $frequency');
  });
  print('');

  // Example 5: Product Description Tagging
  print('Example 5: Product Description Auto-Tagging');
  final product = ProductDescription('Profesyonel Fotoğraf Makinesi', '''
      Yüksek çözünürlüklü sensör ve gelişmiş görüntü işleme teknolojisi ile 
      profesyonel fotoğrafçılık deneyimi. 4K video çekim, optik görüntü 
      sabitleme ve geniş dinamik aralık özellikleri.
    ''');

  final productTags = product.autoTags();
  print('Product: ${product.title}');
  print('Auto Tags: $productTags');
  print('');

  // Example 6: SEO Keyword Analysis
  print('Example 6: SEO Keyword Analysis');
  final seoText = '''
    Web sitesi optimizasyonu için SEO çalışmaları önemlidir. 
    Anahtar kelime araştırması, içerik optimizasyonu ve link building 
    SEO stratejilerinin temel taşlarıdır. Organik trafik artışı için 
    SEO çalışmalarına düzenli devam edilmelidir.
  ''';

  final seoKeywords = KeywordExtractor.extractWithFrequency(seoText, limit: 8);
  print('SEO Text Analysis:');
  seoKeywords.forEach((keyword, frequency) {
    print('  - $keyword: $frequency occurrences');
  });
}

/// Example class for blog post auto-tagging
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

/// Example class for product description tagging
class ProductDescription {
  final String title;
  final String description;

  ProductDescription(this.title, this.description);

  List<String> autoTags() {
    final fullText = '$title $description';
    return KeywordExtractor.extract(fullText, limit: 8);
  }
}
