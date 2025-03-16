import 'package:flutter/material.dart';
import 'package:recipe_book/services/firebase.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseService.initializeFirebase();

  //Testing Firebase connection by adding a recipe
  await FirebaseService.addRecipe(
    recipeName: "Spaghetti Carbonara",
    ingredients: ["Spaghetti", "Eggs", "Pancetta", "Parmesan", "Black Pepper"],
    prepTime: "10 minutes",
    cookTime: "20 minutes",
    category: "Pasta",
    description: "A delicious Italian classic with creamy sauce.",
  );

  print("Recipe added"); //Log Success

  runApp(const MainApp()); 
}


class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Recipe Book',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const HomeScreen(),
    );
  }
}

//Home Screen (Replace Later)
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Recipe Book")),
      body: const Center(child: Text("Check Console for Firebase Logs!")),
    );
  }
}
