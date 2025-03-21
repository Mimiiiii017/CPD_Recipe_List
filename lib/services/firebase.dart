import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseService {
  static final DatabaseReference _databaseRef = FirebaseDatabase.instance.ref("recipes");
  static final FirebaseStorage _storage = FirebaseStorage.instance;

  static Future<void> initializeFirebase() async {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyACs20L0aPLyDNkiye8Mfk3_GM3Juh0mdg",
        authDomain: "cross-platform-dev-6-2a.firebaseapp.com",
        databaseURL: "https://cross-platform-dev-6-2a-default-rtdb.europe-west1.firebasedatabase.app",
        projectId: "cross-platform-dev-6-2a",
        storageBucket: "cross-platform-dev-6-2a.firebasestorage.app",
        messagingSenderId: "717175209965",
        appId: "1:717175209965:web:6c2fcfc6f11cb6024cb1e4",
        measurementId: "G-F7L5MET096",
      ),
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
      print("Firebase Error: $error");
      throw Exception("Failed to save recipe.");
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
      print("Error fetching recipes: $error");
      throw Exception("Failed to fetch recipes.");
    }
  }

  static Future<String> uploadImage(File imageFile) async {
    try {
      final ref = _storage.ref().child('recipe_images/${DateTime.now().millisecondsSinceEpoch}.jpg');
      await ref.putFile(imageFile);
      return await ref.getDownloadURL();
    } catch (error) {
      print("🔥 Image Upload Error: $error");
      throw Exception("Failed to upload image.");
    }
  }
}