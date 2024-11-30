import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'recipe_detail.dart';

class RecipeList extends StatelessWidget {
  final CollectionReference recipes =
      FirebaseFirestore.instance.collection('recipes');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipes'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: recipes.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('No recipes available.'),
            );
          }

          final recipeDocs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: recipeDocs.length,
            itemBuilder: (context, index) {
              final recipe = recipeDocs[index];
              return ListTile(
                leading: recipe['imageUrl'] != null
                    ? Image.network(
                        recipe['imageUrl'],
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      )
                    : Icon(Icons.fastfood),
                title: Text(recipe['title'] ?? 'No Title'),
                subtitle: Text(recipe['cuisine'] ?? 'Unknown Cuisine'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RecipeDetail(recipeId: recipe.id),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
