import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FavoriteService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  //bu metod ile kullanici id'sine göre favoriye eklenen tarifler getiriliyor.
  Stream<QuerySnapshot> getUserFavorites() {
    var ref = _db
        .collection("recipes")
        .where("favoritedUserID", arrayContains: FirebaseAuth.instance.currentUser!.uid)
        .snapshots(); //user favorite movies

    return ref;
  }

  //bu metod ürünün favorilerde olup olmadığını kontrol ediyor.
  //bu kontrolü yaparken listeyi userID ve urunName ile filtreliyor
  Future<bool> countDocuments(String urunName) async {
    QuerySnapshot _myDoc = await _db
        .collection('recipes')
        .where("urunAdi", isEqualTo: urunName)
        .where("favoritedUserID", arrayContains: FirebaseAuth.instance.currentUser?.uid)
        .get(); //Burayı urun id olarak degistirecegiz
    List<DocumentSnapshot> _myDocCount = _myDoc.docs;
    if (_myDocCount.isNotEmpty) {
      return true;
    }
    return false;
  }

  Future addToFavorite(docID) async {
    try {
      //direkt aynı id ile eklemek icin üstteki gibi kullandık
      var ref = _db.collection("recipes").doc(docID).update({
        'favoritedUserID': FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.uid])
      });

      return ref;

      /*await ref.add({
        'userID': userID,
        'urunID': urunID,
        'urunAdi': urunAdi,
        'urunPuani': urunPuani,
        'urunGorseli': urunGorseli,
        'hazirlamaSuresi': hazirlamaSuresi,
      });*/ //buraya bakılacak

    } catch (e) {}
  }

  Future<void> removeFavorite(String docId) {
    var ref = _db.collection("recipes").doc(docId).update({
      'favoritedUserID': FieldValue.arrayRemove([FirebaseAuth.instance.currentUser!.uid])
    });

    return ref;
  }
}
