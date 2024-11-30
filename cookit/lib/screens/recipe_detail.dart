import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RecipeDetail extends StatelessWidget {
  final String recipeId;

  RecipeDetail({required this.recipeId});

  @override
  Widget build(BuildContext context) {
    final DocumentReference recipeDoc =
        FirebaseFirestore.instance.collection('recipes').doc(recipeId);

    return Scaffold(
      appBar: AppBar(
        title: Text('Recipe Details'),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: recipeDoc.get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(
              child: Text('Recipe not found.'),
            );
          }

          final recipe = snapshot.data!.data() as Map<String, dynamic>;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (recipe['imageUrl'] != null)
                  Image.network(
                    recipe['imageUrl'],
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                SizedBox(height: 16),
                Text(
                  recipe['title'] ?? 'No Title',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'Cuisine: ${recipe['cuisine'] ?? 'Unknown'}',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),
                Text(
                  recipe['description'] ?? 'No Description',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),
                Text(
                  'Ingredients:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                ...List.generate(
                  (recipe['ingredients'] as List).length,
                  (index) => Text('- ${recipe['ingredients'][index]}'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
