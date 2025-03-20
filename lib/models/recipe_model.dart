class Recipe {
  final String id;
  final String name;
  final List<String> ingredients;
  final String instructions;
  final String prepTime;
  final String cookTime;
  final String servings;
  final String category;
  final String imageUrl; 

  Recipe({
    required this.id,
    required this.name,
    required this.ingredients,
    required this.instructions,
    required this.prepTime,
    required this.cookTime,
    required this.servings,
    required this.category,
    required this.imageUrl,
  });

  factory Recipe.fromMap(Map<String, dynamic> data, String documentId) {
    return Recipe(
      id: documentId,
      name: data['name'] ?? '',
      ingredients: List<String>.from(data['ingredients'] ?? []),
      instructions: data['instructions'] ?? '',
      prepTime: data['prepTime'] ?? '',
      cookTime: data['cookTime'] ?? '',
      servings: data['servings'] ?? '',
      category: data['category'] ?? '',
      imageUrl: data['imageUrl'] ?? '', 
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'ingredients': ingredients,
      'instructions': instructions,
      'prepTime': prepTime,
      'cookTime': cookTime,
      'servings': servings,
      'category': category,
      'imageUrl': imageUrl, 
    };
  }
}
