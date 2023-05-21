import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projectmanagement/models/urun.dart';

class RecipeService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getUruns() {
    var ref = _db.collection("recipes").snapshots(); //recipes
    return ref;
  }

  Stream<QuerySnapshot> getPopularUruns() {
    var ref = _db
        .collection("recipes")
        .where("urunTipi", arrayContains: "Popular")
        .snapshots(); //movies with a spesific category

    return ref;
  }

  Stream<QuerySnapshot> getOrderedUruns() {
    var ref = _db
        .collection("recipes")
        .where("urunTipi", arrayContains: "Popular")
        .snapshots(); //movies with a spesific category

    return ref;
  }

  Stream<QuerySnapshot> getRecommendedUruns() {
    var ref = _db
        .collection("recipes")
        .where("urunTipi", arrayContains: "Recommended")
        .snapshots(); //movies with a spesific category

    return ref;
  }

  Stream<QuerySnapshot> getCategoryUruns(String categoryName) {
    var ref = _db
        .collection("recipes")
        .where("urunTipi", arrayContains: categoryName)
        .snapshots(); //movies with a spesific category

    return ref;
  }

  Stream<QuerySnapshot> getTitleUruns(List<String> searchArray) {
    var ref = _db
        .collection("recipes")
        .where("urunAdiArray", arrayContainsAny: searchArray)
        .snapshots(); //movies with a spesific category

    return ref;
  }

  Future addUrun(
      String urunAdi,
      List<String> urunTipi,
      String hazirlamaSuresi,
      String urunGorseli,
      String urunPuani,
      String urunTarifi,
      List<String> malzemeler,
      List<String> urunAdiArray,
      Map malzemelerMap) async {
    try {
      var ref = _db.collection("recipes");

      var documentRef = await ref.add({
        'urunAdi': urunAdi,
        'hazirlamaSuresi': hazirlamaSuresi,
        'urunGorseli': urunGorseli,
        'urunPuani': urunPuani,
        'urunTarifi': urunTarifi,
        'urunTipi': urunTipi,
        'malzemeler': malzemeler,
        'urunAdiArray': urunAdiArray,
        'malzemelerMap': malzemelerMap
      }); //buraya bakılacak
      return Urun(
          urunId: documentRef.id,
          urunAdi: urunAdi,
          hazirlamaSuresi: hazirlamaSuresi,
          urunGorseli: urunGorseli,
          urunPuani: urunPuani,
          urunTarifi: urunTarifi,
          urunTipi: urunTipi,
          malzemeler: malzemeler);
    } catch (e) {
      return ;
    }
  }

  Future<List<String>> getRecipeNames(List<String> recipeIDs) async {
    List<String> recipeNames = [];

    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('recipes').where(FieldPath.documentId, whereIn: recipeIDs).get();

    querySnapshot.docs.forEach((doc) {
      if (doc.data() != null) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        String recipeName = data['recipeName'];
        recipeNames.add(recipeName);
      }
    });

    return recipeNames;
  }
}
