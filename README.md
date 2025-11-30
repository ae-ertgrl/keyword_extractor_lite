# keyword_extractor_lite

[![Pub Version](https://img.shields.io/pub/v/keyword_extractor_lite)](https://pub.dev/packages/keyword_extractor_lite)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

Metinlerden en sık geçen anahtar kelimeleri çıkaran **hafif**, **bağımlılıksız** bir Dart paketi. Otomatik etiketleme, SEO analizi, içerik kategorizasyonu ve daha fazlası için mükemmel.

## ✨ Özellikler

- **🚀 Hafif & Hızlı** - Minimal boyut, yüksek performans
- **📦 Sıfır Bağımlılık** - Saf Dart implementasyonu
- **🔧 Kullanımı Kolay** - Basit ve sezgisel API
- **🌐 Platform Bağımsız** - Backend (Serverpod), İstemci, CLI ve Web'de çalışır
- **🇹🇷 Türkçe Optimize** - Yerleşik Türkçe stop-word'ler (diğer diller için genişletilebilir)

## 📋 Kullanım Alanları

- SaaS uygulamalarında **otomatik etiketleme**
- İçerik optimizasyonu için **SEO anahtar kelime analizi**
- **İçerik kategorizasyonu** ve sınıflandırma
- Kullanıcı tarafından oluşturulan içeriklerden **etiket çıkarma**
- **Metin özetleme** ve konu tespiti

## 🚀 Başlangıç

`keyword_extractor_lite` paketini `pubspec.yaml` dosyanıza ekleyin:

```yaml
dependencies:
  keyword_extractor_lite: ^1.0.0
```

Ardından şu komutu çalıştırın:

```bash
dart pub get
```

## 💡 Kullanım

### Temel Örnek

```dart
import 'package:keyword_extractor_lite/keyword_extractor_lite.dart';

void main() {
  final metin = '''
    Flutter ve Dart ile mobil uygulama geliştirmek çok kolay. 
    Flutter cross-platform uygulama geliştirme için harika bir framework. 
    Dart dili modern ve güçlü bir programlama dilidir.
  ''';

  // En sık geçen 5 kelimeyi çıkar (varsayılan)
  final anahtarKelimeler = KeywordExtractor.extract(metin);
  print(anahtarKelimeler); // Çıktı: [flutter, dart, uygulama, geliştirme, dili]
}
```

### Özel Limit

```dart
import 'package:keyword_extractor_lite/keyword_extractor_lite.dart';

void main() {
  final metin = '''
    Yapay zeka teknolojileri hızla gelişiyor. Makine öğrenmesi ve 
    derin öğrenme yapay zeka alanında önemli rol oynuyor.
  ''';

  // En sık geçen 3 kelimeyi çıkar
  final anahtarKelimeler = KeywordExtractor.extract(metin, limit: 3);
  print(anahtarKelimeler); // Çıktı: [yapay, zeka, öğrenme]
}
```

### Gerçek Dünya Örneği: Blog Yazılarını Otomatik Etiketleme

```dart
import 'package:keyword_extractor_lite/keyword_extractor_lite.dart';

class BlogYazisi {
  final String baslik;
  final String icerik;
  List<String> etiketler = [];

  BlogYazisi(this.baslik, this.icerik);

  void etiketOlustur() {
    final birlesikMetin = '$baslik $icerik';
    etiketler = KeywordExtractor.extract(birlesikMetin, limit: 5);
  }
}

void main() {
  final yazi = BlogYazisi(
    'Flutter ile Mobil Uygulama Geliştirme',
    '''
      Flutter, Google tarafından geliştirilen açık kaynaklı bir UI framework'tür.
      Dart programlama dili kullanarak iOS ve Android için native uygulamalar 
      geliştirebilirsiniz. Hot reload özelliği sayesinde geliştirme süreci 
      oldukça hızlı ve verimlidir.
    ''',
  );

  yazi.etiketOlustur();
  print('Oluşturulan Etiketler: ${yazi.etiketler}');
  // Çıktı: Oluşturulan Etiketler: [flutter, dart, uygulama, geliştirme, native]
}
```

### SaaS Uygulaması Örneği: Kullanıcı Açıklamalarından Etiket Çıkarma

```dart
import 'package:keyword_extractor_lite/keyword_extractor_lite.dart';

class UrunAciklamasi {
  final String baslik;
  final String aciklama;
  
  UrunAciklamasi(this.baslik, this.aciklama);
  
  List<String> otomatikEtiketler() {
    final tamMetin = '$baslik $aciklama';
    return KeywordExtractor.extract(tamMetin, limit: 8);
  }
}

void main() {
  final urun = UrunAciklamasi(
    'Profesyonel Fotoğraf Makinesi',
    '''
      Yüksek çözünürlüklü sensör ve gelişmiş görüntü işleme teknolojisi ile 
      profesyonel fotoğrafçılık deneyimi. 4K video çekim, optik görüntü 
      sabitleme ve geniş dinamik aralık özellikleri. Hem fotoğraf hem de 
      video çekimi için ideal.
    ''',
  );

  final etiketler = urun.otomatikEtiketler();
  print('Otomatik Etiketler: $etiketler');
  // Çıktı: [fotoğraf, video, profesyonel, çekim, görüntü, teknolojisi, hem, özellikleri]
}
```

## 🔧 API Referansı

### `KeywordExtractor.extract()`

Verilen metinden en sık geçen anahtar kelimeleri çıkarır.

**Parametreler:**
- `text` (String, zorunlu) - Anahtar kelimelerin çıkarılacağı metin
- `limit` (int, opsiyonel) - Döndürülecek maksimum anahtar kelime sayısı (varsayılan: 5)

**Döndürür:**
- `List<String>` - Sıklığa göre sıralanmış anahtar kelime listesi (en sık geçenden başlayarak)

**Nasıl Çalışır:**
1. Metni küçük harfe çevirir
2. Özel karakterleri temizler (Türkçe karakterleri korur: ğ, ü, ş, ı, ö, ç)
3. Stop-word'leri filtreler (yaygın Türkçe kelimeler: "ve", "ile", "bir", vb.)
4. 3 karakterden kısa kelimeleri filtreler
5. Kelime sıklığını hesaplar
6. En sık geçen N kelimeyi döndürür

## 🌍 Dil Desteği

Şu anda **Türkçe** için optimize edilmiştir ve yerleşik Türkçe stop-word'ler içerir. Paket, stop-word setini değiştirerek diğer dilleri destekleyecek şekilde kolayca genişletilebilir.

**Yerleşik Türkçe stop-word'ler:**
`ve`, `ile`, `ama`, `fakat`, `için`, `bir`, `bu`, `şu`, `o`, `da`, `de`, `mi`, `mı`

## 🎯 Performans

- **Hafif**: Harici bağımlılık yok
- **Hızlı**: Verimli frekans tabanlı algoritma
- **Bellek Dostu**: Metni tek geçişte işler

## 📝 Örnek Çıktılar

```dart
final metin = 'Serverpod backend geliştirme için mükemmel bir framework. '
             'Serverpod ile API geliştirmek çok kolay.';

final anahtarKelimeler = KeywordExtractor.extract(metin, limit: 3);
print(anahtarKelimeler); // [serverpod, geliştirme, framework]
```

```dart
final metin = '''
  E-ticaret platformumuz müşteri memnuniyetini ön planda tutar.
  Hızlı kargo, güvenli ödeme ve kaliteli ürünler sunuyoruz.
  Müşteri hizmetleri ekibimiz her zaman yanınızda.
''';

final etiketler = KeywordExtractor.extract(metin, limit: 6);
print(etiketler); // [müşteri, ürünler, ticaret, platform, hızlı, güvenli]
```

## 🛠️ Gelişmiş Kullanım

### Serverpod Backend Entegrasyonu

```dart
import 'package:keyword_extractor_lite/keyword_extractor_lite.dart';
import 'package:serverpod/serverpod.dart';

class MakaleEndpoint extends Endpoint {
  Future<List<String>> makaleEtiketleriOlustur(
    Session session,
    String makaleIcerigi,
  ) async {
    // Makaleden otomatik etiket oluştur
    final etiketler = KeywordExtractor.extract(
      makaleIcerigi,
      limit: 10,
    );
    
    return etiketler;
  }
}
```

### Flutter Uygulamasında Kullanım

```dart
import 'package:flutter/material.dart';
import 'package:keyword_extractor_lite/keyword_extractor_lite.dart';

class EtiketOlusturucu extends StatefulWidget {
  @override
  _EtiketOlusturucuState createState() => _EtiketOlusturucuState();
}

class _EtiketOlusturucuState extends State<EtiketOlusturucu> {
  final TextEditingController _controller = TextEditingController();
  List<String> _etiketler = [];

  void _etiketleriOlustur() {
    setState(() {
      _etiketler = KeywordExtractor.extract(_controller.text, limit: 8);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _controller,
          decoration: InputDecoration(labelText: 'Metninizi girin'),
          maxLines: 5,
        ),
        ElevatedButton(
          onPressed: _etiketleriOlustur,
          child: Text('Etiket Oluştur'),
        ),
        Wrap(
          spacing: 8,
          children: _etiketler
              .map((etiket) => Chip(label: Text(etiket)))
              .toList(),
        ),
      ],
    );
  }
}
```

## 🤝 Katkıda Bulunma

Katkılarınızı bekliyoruz! Ek dil desteği eklemek veya algoritmayı geliştirmek isterseniz, lütfen bir issue açın veya pull request gönderin.

## 📄 Lisans

Bu proje MIT Lisansı altında lisanslanmıştır - detaylar için [LICENSE](LICENSE) dosyasına bakın.

## 👨‍💻 Yazar

Dart ve Flutter topluluğu için ❤️ ile geliştirildi.

**Geliştirici:** Abdurrahman Ertuğrul

---

**Bu paketi faydalı buldunuz mu?** [GitHub](https://github.com/my_org/my_repo)'da ⭐ verin!
