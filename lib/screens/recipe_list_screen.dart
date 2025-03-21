import 'package:flutter/material.dart';
import '../services/firebase.dart';

class RecipeListScreen extends StatefulWidget {
  const RecipeListScreen({super.key});

  @override
  State<RecipeListScreen> createState() => _RecipeListScreenState();
}

class _RecipeListScreenState extends State<RecipeListScreen> {
  List<Map<String, dynamic>> recipes = [];

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
      appBar: AppBar(
        backgroundColor: const Color(0xFF2F696B),
        title: const Text('Recipe List', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: recipes.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                final recipe = recipes[index];
                final imageUrl = recipe['imageUrl'];


                print('Image URL: $imageUrl');

return Card(
  child: Container(
    height: 140, 
    padding: const EdgeInsets.all(10), 
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ListTile(
          leading: (imageUrl != null && imageUrl.isNotEmpty)
              ? Image.network(
                  imageUrl,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    print("Image Load Error: $error"); 
                    return const Icon(Icons.broken_image, size: 50);
                  },
                )
              : const Icon(Icons.image, size: 50),
          title: Text(
            recipe['name'] ?? 'No Name',
            style: const TextStyle(
              color: Color(0xFF2F696B),
              fontWeight: FontWeight.w900,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(recipe['category'] ?? 'No Category'),
              Text(recipe['description'] ?? 'No Description'),
            ],
          ),
        ),
        SizedBox(
          width: double.infinity, 
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2F696B),
              padding: const EdgeInsets.symmetric(vertical: 15),
            ),
            child: const Text("VIEW RECIPE", style: TextStyle(color: Colors.white)),
            onPressed: () {
              
            },
          ),
        ),
      ],
    ),
  ),
);
              },
            ),
    );
  }
} 
