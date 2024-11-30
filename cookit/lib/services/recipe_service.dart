import 'package:cloud_firestore/cloud_firestore.dart';

class RecipeService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addRecipe(String title, String description, String imageUrl, String cuisine, List<String> ingredients, String authorID) async{
    await _firestore.collection('recipes').add({
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'cuisine': cuisine,
      'ingredients': ingredients,
      'authorId': authorID,
    });
  } 

  Stream<QuerySnapshot> getRecipes() {
    return _firestore.collection('recipes').snapshots();
  }

  Stream<QuerySnapshot> searchRecipes(String query) {
  return _firestore
      .collection('recipes')
      .where('title', isGreaterThanOrEqualTo: query)
      .where('title', isLessThanOrEqualTo: query + '\uf8ff')
      .snapshots();
  }

  Stream<QuerySnapshot> filterByCuisine(String cuisine) {
  return _firestore.collection('recipes').where('cuisine', isEqualTo: cuisine).snapshots();
}


}