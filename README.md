# Directory - Rehber Projesi MOTOKO
Bu proje, isimleri ve numaraları bir rehberde kaydedip, sorgulama ve tüm kayıtları listeleme işlemleri yapabileceğiniz bir sistem sunar. Aşağıdaki özellikleri içerir:

1. Projenin Amacı

Bu proje, kullanıcıların:
İsimleri (Text) ve numaraları (Nat) rehberde ayrı ayrı kaydedebilmesini,
İsim ve numaraları birbirine bağlayarak ilişkili şekilde saklayabilmesini,
Bu verilere dayalı sorgulamalar yapabilmesini,
Tüm kayıtları listeleyebilmesini sağlar.

2. Kütüphaneler ve Modüller

Proje aşağıdaki kütüphaneleri kullanır:
mo:base/Text: Metin (String) işlemleri için gerekli eşitlik ve hash fonksiyonları.
mo:base/HashMap: İsimler ve numaralar için harita veri yapısını kullanma.
mo:base/Nat32: Nat türünü Nat32'ye dönüştürmek için kullanılır.
mo:base/Array: Kayıtların birleştirilmesi ve listeleme işlemleri.

3. Fonksiyonlar

3.1. registerText(name: Text)
Görevi: Yeni bir isim kaydı oluşturur.
Çalışma Mantığı: Eğer verilen isim daha önce kaydedilmemişse, isim bir kimlik numarasıyla (Nat) eşleştirilir ve textMap içinde saklanır.

3.2. registerNumber(number: Nat, name: Text)
Görevi: Yeni bir numara kaydı oluşturur ve isme bağlar.
Çalışma Mantığı: Eğer verilen numara daha önce kaydedilmemişse, numara ve isim numberMap içinde saklanır.

3.3. lookupByText(name: Text)
Görevi: Verilen bir isme karşılık gelen kimlik numarasını döndürür.
Dönen Değer: Eğer kayıt bulunursa, numarayı (Nat) döndürür. Aksi takdirde null döner.

3.4. lookupByNumber(number: Nat)
Görevi: Verilen bir numaraya karşılık gelen ismi döndürür.
Dönen Değer: Eğer kayıt bulunursa, ismi (Text) döndürür. Aksi takdirde null döner.

3.5. linkTextToNumber(name: Text, number: Nat)
Görevi: Bir isim ve numarayı ilişkilendirir.
Çalışma Mantığı:
Eğer isim textMap içinde kayıtlıysa, numara da kaydedilir ve ilişkilendirilir.
Eğer isim kayıtlı değilse null döner.
Dönen Değer: Başarılı bir bağlantı durumunda ismi döndürür.

3.6. getAllRecords()
Görevi: Tüm kayıtları liste halinde döndürür.
Çalışma Mantığı:
Hem isim (textMap) hem de numara (numberMap) kayıtlarını toplar.
Bu kayıtları (Text, Nat) şeklinde bir liste olarak döndürür.
Dönen Değer: [(Text, Nat)] formatında tüm rehber kayıtları.

4. Teknik Detaylar

Haritalar (HashMap):
textMap: İsimleri ve onların benzersiz kimlik numaralarını saklar.
numberMap: Numaraları ve onlara bağlı isimleri saklar.
Iterator Kullanımı: getAllRecords() fonksiyonu harita içindeki kayıtları dolaşmak için iterator kullanır.
Tuple Dönüşümleri: İsim ve numara kayıtları doğru formatta listeye eklenir.
Array Modülü: Listeleme işlemleri için Array.append kullanılır.

5. Sınırlamalar

Haritaların başlangıç boyutları (10) statik olarak belirlenmiştir. Daha büyük veritabanı ihtiyacı için harita boyutunu artırmanız gerekebilir.
İsim ve numaralar birbirinden bağımsız olarak da kaydedilebilir; ancak bu durumda linkTextToNumber fonksiyonunun etkili çalışması için isimlerin önceden kaydedilmiş olması gerekir.

6. Geliştirme Önerileri

Harita boyutlarını dinamik hale getirmek.
Daha fazla sorgulama fonksiyonu (örneğin, isimle başlayan numaraları arama) eklemek.
İlişkilendirilmiş verilerin silinmesi için delete fonksiyonları eklemek.
