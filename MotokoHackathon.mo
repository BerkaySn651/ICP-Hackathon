import Text "mo:base/Text";
import Map "mo:base/HashMap";
import Nat32 "mo:base/Nat32";
import Array "mo:base/Array";  // Array modülünü içe aktarma

actor Directory {

  // Text tabanlı kayıtlar için harita
  let textMap = Map.HashMap<Text, Nat>(10, Text.equal, Text.hash);

  // Nat tabanlı kayıtlar için harita
  let numberMap = Map.HashMap<Nat, Text>(
    10,
    func (a: Nat, b: Nat) : Bool { a == b }, // Nat için eşitlik kontrolü
    func (n: Nat) : Nat32 {
      Nat32.fromNat(n) 
    }
  );

  // Metin kaydı ekler
  public func registerText(name: Text) : async () {
    switch (textMap.get(name)) {
      case null {
        textMap.put(name, textMap.size());
      };
      case (?id) { }; // Zaten varsa işlem yapılmaz
    }
  };

  // Rakam kaydı ekler
  public func registerNumber(number: Nat, name: Text) : async () {
    switch (numberMap.get(number)) {
      case null {
        numberMap.put(number, name);
      };
      case (?existingName) { }; // Zaten varsa işlem yapılmaz
    }
  };

  // Metin tabanlı kaydı arar
  public func lookupByText(name: Text) : async ?Nat {
    textMap.get(name);
  };

  // Rakam tabanlı kaydı arar
  public func lookupByNumber(number: Nat) : async ?Text {
    numberMap.get(number);
  };

  // Metin ve rakamları bağlayan bir rehber oluşturma
  public func linkTextToNumber(name: Text, number: Nat) : async ?Text {
    switch (textMap.get(name)) {
      case null { return null; }; // Metin bulunamazsa işlem yapılmaz
      case (?id) {
        await registerNumber(number, name);
        return ?name;
      };
    }
  };

  // Tüm metin ve numara kayıtlarını döndürür
  public func getAllRecords() : async [(Text, Nat)] {
    var allRecords : [(Text, Nat)] = [];
    
    // Metin tabanlı kayıtları ekleme
    var textIterator = textMap.entries();
    var nextTextOpt = textIterator.next();
    while (nextTextOpt != null) {
      switch (nextTextOpt) {
        case (?entry) {
          allRecords := Array.append(allRecords, [entry]); 
        };
      };
      nextTextOpt := textIterator.next(); // Bir sonraki öğeye geç
    };

    // Rakam tabanlı kayıtları ekleme
    var numberIterator = numberMap.entries();
    var nextNumberOpt = numberIterator.next();
    while (nextNumberOpt != null) {
      switch (nextNumberOpt) {
        case (?entry) {
          // Burada entry.0 ve entry.1 kullanarak doğru türdeki tuple'ı ekliyoruz
          allRecords := Array.append(allRecords, [(entry.1, entry.0)]); // (Nat, Text) -> (Text, Nat)
        };
      };
      nextNumberOpt := numberIterator.next(); // Bir sonraki öğeye geç
    };

    return allRecords;
  };
};
