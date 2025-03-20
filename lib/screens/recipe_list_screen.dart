import 'package:flutter/material.dart';
import '../services/firebase.dart';

class RecipeListScreen extends StatefulWidget {
  const RecipeListScreen({super.key});

  @override
  State<RecipeListScreen> createState() => _RecipeListScreenState();
}

class _RecipeListScreenState extends State<RecipeListScreen> {
  List<Map<String, dynamic>> recipes = [];

  void loadRecipes() async {
    recipes = await FirebaseService.getRecipes();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchRecipes();
  }

  void fetchRecipes() async {
    final data = await FirebaseService.getRecipes();
    setState(() {
      recipes = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD9E7E8),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xFF2F696B),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: const Text('Recipe List', style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
 

      body: ListView.builder(
         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          final recipe = recipes[index];
          return Card(
            child: ListTile(
              title: Text(recipe['name'] ?? 'No Name'),
              subtitle: Text(recipe['category'] ?? 'No Category'),
              onTap: () {
                // Handle tap
              },
            ),
          );
        },
      ),
    );
  }
}

