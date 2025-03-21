import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../firebase_options.dart';

class FirebaseService {
  static final DatabaseReference _databaseRef = FirebaseDatabase.instance.ref("recipes");
  static final FirebaseStorage _storage = FirebaseStorage.instance;

  static Future<void> initializeFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  static Future<void> addRecipe({
    required String recipeName,
    required List<String> ingredients,
    required List<String> instructions,
    required String prepTime,
    required String cookTime,
    required String category,
    required String description,
    String? imageUrl,
  }) async {
    try {
      await _databaseRef.push().set({
        'name': recipeName,
        'ingredients': ingredients,
        'instructions': instructions,
        'prepTime': prepTime,
        'cookTime': cookTime,
        'category': category,
        'description': description,
        'imageUrl': imageUrl ?? "",
      });
    } catch (error) {
      throw Exception("Failed to save recipe: $error");
    }
  }

  static Future<List<Map<String, dynamic>>> getRecipes() async {
    try {
      final snapshot = await _databaseRef.get();
      if (!snapshot.exists || snapshot.value == null) return [];

      return (snapshot.value as Map<dynamic, dynamic>).entries.map((entry) {
        final recipeData = Map<String, dynamic>.from(entry.value);
        recipeData['id'] = entry.key;
        return recipeData;
      }).toList();
    } catch (error) {
      throw Exception("Failed to fetch recipes: $error");
    }
  }

  static Future<String> uploadImage(File imageFile) async {
    try {
      final ref = _storage.ref().child('recipe_images/${DateTime.now().millisecondsSinceEpoch}.jpg');
      await ref.putFile(imageFile);
      return await ref.getDownloadURL();
    } catch (error) {
      throw Exception("Failed to upload image: $error");
    }
  }
}