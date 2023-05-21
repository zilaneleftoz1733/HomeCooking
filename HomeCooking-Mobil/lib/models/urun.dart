class Urun {
  late String urunId;
  late String urunAdi;
  late String hazirlamaSuresi;
  late String urunGorseli;
  late String urunPuani;
  late String urunTarifi;
  late List<String> urunTipi;
  late List<String> malzemeler;

  Urun({
    required this.urunId,
    required this.urunAdi,
    required this.hazirlamaSuresi,
    required this.urunGorseli,
    required this.urunPuani,
    required this.urunTarifi,
    required this.urunTipi,
    required this.malzemeler,
  });

  /*factory Urun.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
        
    return Urun(
      urunId: doc.id,
      urunAdi: data['urunAdi'],
      urunTipi: data['urunTipi'],
      hazirlamaSuresi: data['hazirlamaSuresi'],
      urunGorsel: data['urunGorsel'],
      urunPuani: data['urunPuani'],
      urunTarifi: data['urunTarifi'],
    );
  }*/
}
