import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class RecipeForm extends StatefulWidget {
  @override
  _RecipeFormState createState() => _RecipeFormState();
}

class _RecipeFormState extends State<RecipeForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _cuisineController = TextEditingController();
  final List<String> _ingredients = [];
  File? _selectedImage;

  final List<String> _allIngredients = [
    'Tomato',
    'Onion',
    'Garlic',
    'Chicken',
    'Cheese',
    'Rice',
    'Pasta',
  ]; 

  void _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  void _submitRecipe() {
    if (_formKey.currentState!.validate()) {
      if (_selectedImage == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please select an image.')),
        );
        return;
      }
      if (_ingredients.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please select at least one ingredient.')),
        );
        return;
      }

      final title = _titleController.text.trim();
      final description = _descriptionController.text.trim();
      final cuisine = _cuisineController.text.trim();

      // Add logic to upload recipe details and image
      print("Recipe Submitted: $title, $description, $cuisine, $_ingredients");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Submit Recipe'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(labelText: 'Title'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(labelText: 'Description'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _cuisineController,
                  decoration: InputDecoration(labelText: 'Cuisine'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a cuisine.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                Text(
                  'Select Ingredients',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Wrap(
                  spacing: 8.0,
                  children: _allIngredients.map((ingredient) {
                    final isSelected = _ingredients.contains(ingredient);
                    return FilterChip(
                      label: Text(ingredient),
                      selected: isSelected,
                      onSelected: (bool selected) {
                        setState(() {
                          if (selected) {
                            _ingredients.add(ingredient);
                          } else {
                            _ingredients.remove(ingredient);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
                SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: _pickImage,
                  icon: Icon(Icons.image),
                  label: Text('Pick Image'),
                ),
                if (_selectedImage != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Image.file(
                      _selectedImage!,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                SizedBox(height: 16),
                Center(
                  child: ElevatedButton(
                    onPressed: _submitRecipe,
                    child: Text('Submit Recipe'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
