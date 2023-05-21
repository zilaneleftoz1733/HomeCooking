import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projectmanagement/services/adress_service.dart';

class OrderService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  //bu metod ile kullanici id'sine göre siparişe eklenen tarifler getiriliyor.
  Stream<QuerySnapshot> getShoppingBag() {
    var ref = _db
        .collection("recipes")
        .where("orderedUserID", arrayContains: FirebaseAuth.instance.currentUser!.uid)
        .snapshots(); //user favorite movies

    return ref;
  }

  Stream<QuerySnapshot> getUserCompletedOrders() {
    var ref = _db
        .collection("orders")
        .where("userID", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .orderBy("orderDate", descending: true)
        .snapshots(); //user favorite movies

    return ref;
  }

  //bu metod ürünün favorilerde olup olmadığını kontrol ediyor.
  //bu kontrolü yaparken listeyi userID ve urunName ile filtreliyor
  Future<bool> countDocuments(String urunName) async {
    QuerySnapshot _myDoc = await _db
        .collection('recipes')
        .where("urunAdi", isEqualTo: urunName)
        .where("orderedUserID", arrayContains: FirebaseAuth.instance.currentUser?.uid)
        .get(); //Burayı urun id olarak degistirecegiz
    List<DocumentSnapshot> _myDocCount = _myDoc.docs;
    if (_myDocCount.isNotEmpty) {
      return true;
    }
    return false;
  }

  Future addToOrders(docID) async {
    try {
      //direkt aynı id ile eklemek icin üstteki gibi kullandık
      var ref = _db.collection("recipes").doc(docID).update({
        'orderedUserID': FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.uid])
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

  Future<void> removeOrders(String docId) {
    var ref = _db.collection("recipes").doc(docId).update({
      'orderedUserID': FieldValue.arrayRemove([FirebaseAuth.instance.currentUser!.uid])
    });

    return ref;
  }

  Future<void> addConfirmOrder(
    Timestamp orderDate,
    String orderPrice,
    List<String> orders,
    List<String> ordersNames,
  ) async {
    try {
      var ref = _db.collection("orders");

      String userAdress = await AdressService().getUserAdress() ?? ' ';

      //var documentRef=

      await ref.add({
        'orderDate': orderDate,
        'orderPrice': orderPrice,
        'orderStatus': "Preparing",
        'orders': orders,
        'ordersNames': ordersNames,
        'userAdress': userAdress,
        'userID': FirebaseAuth.instance.currentUser?.uid,
      }); //buraya bakılacak
    } catch (e) {}
  }

  Future<void> deleteUserIdFromOrders() async {
    var snapshot = await _db
        .collection("recipes")
        .where("orderedUserID", arrayContains: FirebaseAuth.instance.currentUser?.uid)
        .get();

    // Her bir döküman için güncelleme yapın
    for (var doc in snapshot.docs) {
      var orderedUserIDs = List<String>.from(doc["orderedUserID"]);
      orderedUserIDs.remove(FirebaseAuth.instance.currentUser?.uid);

      // Güncellenmiş kullanıcı id listesini Firestore'a kaydedin
      await doc.reference.update({"orderedUserID": orderedUserIDs});
    }
  }
}
