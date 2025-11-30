import 'package:keyword_extractor_lite/keyword_extractor_lite.dart';

/// Basit ve hızlı kullanım örnekleri
void main() {
  print('🚀 KEYWORD EXTRACTOR LITE - Hızlı Başlangıç\n');

  // ═══════════════════════════════════════════════════════════
  // ÖRNEK 1: En Basit Kullanım
  // ═══════════════════════════════════════════════════════════
  print('1️⃣  En Basit Kullanım:');
  print('─' * 50);
  
  final metin = 'Flutter ile mobil uygulama geliştirmek çok kolay ve eğlenceli.';
  final kelimeler = KeywordExtractor.extract(metin);
  
  print('Metin: $metin');
  print('Anahtar Kelimeler: $kelimeler\n');

  // ═══════════════════════════════════════════════════════════
  // ÖRNEK 2: Limit Belirleyerek
  // ═══════════════════════════════════════════════════════════
  print('2️⃣  Limit Belirleyerek (Top 3):');
  print('─' * 50);
  
  final uzunMetin = '''
    Dart programlama dili modern, güçlü ve verimli bir dildir.
    Dart ile hem mobil hem web uygulamaları geliştirebilirsiniz.
  ''';
  
  final top3 = KeywordExtractor.extract(uzunMetin, limit: 3);
  print('Top 3 Kelime: $top3\n');

  // ═══════════════════════════════════════════════════════════
  // ÖRNEK 3: Frekans ile Birlikte
  // ═══════════════════════════════════════════════════════════
  print('3️⃣  Frekans Bilgisi ile:');
  print('─' * 50);
  
  final tekrarliMetin = 'Flutter Flutter Dart Dart Dart uygulama';
  final frekans = KeywordExtractor.extractWithFrequency(tekrarliMetin);
  
  print('Metin: $tekrarliMetin');
  frekans.forEach((kelime, sayi) {
    print('  • $kelime: $sayi kez');
  });
  print('');

  // ═══════════════════════════════════════════════════════════
  // ÖRNEK 4: Gerçek Dünya - Blog Etiketleme
  // ═══════════════════════════════════════════════════════════
  print('4️⃣  Blog Yazısı Etiketleme:');
  print('─' * 50);
  
  final blog = BlogYazisi(
    baslik: 'Serverpod ile Backend Geliştirme',
    icerik: '''
      Serverpod, Dart dilinde yazılmış modern bir backend framework'tür.
      API geliştirme, veritabanı yönetimi ve real-time özellikler sunar.
    ''',
  );
  
  print('Blog: ${blog.baslik}');
  print('Etiketler: ${blog.etiketler}\n');

  // ═══════════════════════════════════════════════════════════
  // ÖRNEK 5: E-Ticaret Ürün Etiketleme
  // ═══════════════════════════════════════════════════════════
  print('5️⃣  Ürün Otomatik Etiketleme:');
  print('─' * 50);
  
  final urun = Urun(
    ad: 'Kablosuz Bluetooth Kulaklık',
    aciklama: 'Premium ses kalitesi, uzun pil ömrü, konforlu tasarım',
  );
  
  print('Ürün: ${urun.ad}');
  print('Otomatik Etiketler: ${urun.etiketler}\n');

  // ═══════════════════════════════════════════════════════════
  // ÖZET
  // ═══════════════════════════════════════════════════════════
  print('═' * 50);
  print('✅ Tüm örnekler başarıyla çalıştı!');
  print('📦 Paket hazır ve kullanıma uygun!');
  print('═' * 50);
}

// Helper sınıflar
class BlogYazisi {
  final String baslik;
  final String icerik;
  late final List<String> etiketler;

  BlogYazisi({required this.baslik, required this.icerik}) {
    final tumMetin = '$baslik $icerik';
    etiketler = KeywordExtractor.extract(tumMetin, limit: 5);
  }
}

class Urun {
  final String ad;
  final String aciklama;
  late final List<String> etiketler;

  Urun({required this.ad, required this.aciklama}) {
    final tumMetin = '$ad $aciklama';
    etiketler = KeywordExtractor.extract(tumMetin, limit: 6);
  }
}
