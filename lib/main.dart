import 'package:flutter/material.dart';
import 'screens/add_recipe_screen.dart'; 
import 'screens/recipe_details_screen.dart'; 
import 'screens/recipe_list_screen.dart'; 
import 'services/firebase.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseService.initializeFirebase();

  runApp(const RecipeApp());
}

class RecipeApp extends StatelessWidget {
  const RecipeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe App',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFCCDEDF),
      ),
      home: const AddRecipeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
