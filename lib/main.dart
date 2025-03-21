  import 'package:flutter/material.dart';
  import 'package:recipe_book/screens/recipe_list_screen.dart';
  import 'screens/add_recipe_screen.dart';
  import 'screens/Welcome_Page.dart';
  import 'services/firebase.dart';
  import 'package:firebase_analytics/firebase_analytics.dart';
  import 'package:firebase_analytics/observer.dart';

  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

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
        primaryColor: const Color(0xFF2F696B),
        hintColor: const Color(0xFFD9E7E8),
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: analytics), 
      ],
    );
  }
}

  class HomeScreen extends StatelessWidget {
    const HomeScreen({super.key});

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF2F696B),
          title: const Text('My Recipe Book', style: TextStyle(color: Colors.white)),
          actions: [
            PopupMenuButton<String>(
              icon: const Icon(Icons.menu, color: Colors.white),
              onSelected: (String result) {
                if (result == 'Add Recipe') {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const AddRecipeScreen()));
                }
                if (result == 'View Recipes') {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const RecipeListScreen()));
                } 
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'Add Recipe',
                  child: Text('Add Recipe'),
                ),
                const PopupMenuItem<String>(
                  value: 'View Recipes',
                  child: Text('View Recipes'),
                ),
              ],
            ),
          ],
        ),
        body: const WelcomePage(),
      );
    }
  }