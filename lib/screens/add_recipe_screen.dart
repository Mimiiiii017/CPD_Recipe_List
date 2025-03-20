import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../services/firebase.dart';

class AddRecipeScreen extends StatefulWidget {
  const AddRecipeScreen({super.key});

  State<AddRecipeScreen> createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final _formKey = GlobalKey<FormState>();

  final recipeNameController = TextEditingController();
  final ingredientsController = TextEditingController();
  final instructionsController = TextEditingController();
  final prepTimeController = TextEditingController();
  final cookTimeController = TextEditingController();
  final servingsController = TextEditingController();
  final categoryController = TextEditingController();

  File? selectedImage;

  void takePhoto() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      setState(() {
        selectedImage = File(pickedImage.path);
      });
    }
  }

  void submitRecipe() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseService.addRecipe(
          recipeName: recipeNameController.text,
          ingredients: ingredientsController.text.split(","),
          prepTime: prepTimeController.text,
          cookTime: cookTimeController.text,
          category: categoryController.text,
          description: instructionsController.text,
          imageFile: selectedImage,
        );

        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Recipe added successfully!")));
        _formKey.currentState!.reset();
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Error: $e")));
      }
    }
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
            title: const Text('Add Recipe Form', style: TextStyle(color: Colors.white)),
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),  
              ],
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text("ADD RECIPE",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Color(0xFF2F696B),
                          fontSize: 24,
                          fontWeight: FontWeight.w900)),

                  const SizedBox(height: 20),

                  TextFormField(
                    controller: recipeNameController,
                    decoration: const InputDecoration(
                        labelText: "Recipe Name", 
                        labelStyle: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF626262)), 
                        border: OutlineInputBorder()),
                    validator: (val) => val!.isEmpty ? "Enter a recipe name" : null,
                  ),

                  const SizedBox(height: 15),

                  TextFormField(
                    controller: ingredientsController,
                    decoration: const InputDecoration(
                        labelText: "Ingredients", 
                        labelStyle: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF626262)), 
                        border: OutlineInputBorder()),
                    validator: (val) => val!.isEmpty ? "Enter ingredients" : null,
                  ),

                      const SizedBox(height: 5),

                  Text("Comma to separate each ingredient",
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          color: Color(0xFF2F696B),
                          fontSize: 12,
                          fontWeight: FontWeight.w500)),

                  const SizedBox(height: 15),

                  TextFormField(
                    controller: instructionsController,
                    decoration: const InputDecoration(
                        labelText: "Instructions", 
                        labelStyle: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF626262)), 
                        border: OutlineInputBorder()),
                    validator: (val) => val!.isEmpty ? "Enter instructions" : null,
                  ),

                  const SizedBox(height: 5),

                  Text("Comma to separate each instruction",
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          color: Color(0xFF2F696B),
                          fontSize: 12,
                          fontWeight: FontWeight.w500)),

                  const SizedBox(height: 15),

                  TextFormField(
                    controller: prepTimeController,
                    decoration: const InputDecoration(
                        labelText: "Prep Time", 
                        labelStyle: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF626262)), 
                        border: OutlineInputBorder()),
                    validator: (val) => val!.isEmpty ? "Enter Prep Time" : null,
                  ),

                  const SizedBox(height: 15),

                  TextFormField(
                    controller: cookTimeController,
                    decoration: const InputDecoration(
                        labelText: "Cook Time", 
                        labelStyle: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF626262)), 
                        border: OutlineInputBorder()),
                    validator: (val) => val!.isEmpty ? "Enter Cook Time" : null,
                  ),

                  const SizedBox(height: 15),

                  TextFormField(
                    controller: servingsController,
                    decoration: const InputDecoration(
                        labelText: "Servings", 
                        labelStyle: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF626262)), 
                        border: OutlineInputBorder()),
                    validator: (val) => val!.isEmpty ? "Enter Servings" : null,
                  ),

                  const SizedBox(height: 15),

                  TextFormField(
                    controller: categoryController,
                    decoration: const InputDecoration(
                        labelText: "Category", 
                        labelStyle: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF626262)), 
                        border: OutlineInputBorder()),
                    validator: (val) => val!.isEmpty ? "Enter a Category" : null,
                  ),

                  const SizedBox(height: 15),

                  OutlinedButton.icon(
                    onPressed: takePhoto,
                    icon: const Icon(Icons.camera_alt, color: Color(0xFF2F696B)),
                    label: const Text("Take Photo", style: TextStyle(color: Color(0xFF2F696B))),
                    style: OutlinedButton.styleFrom(
                      fixedSize: const Size.fromHeight(100),
                      side: BorderSide(color: const Color(0xFF2F696B), style: BorderStyle.solid),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2F696B),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    onPressed: submitRecipe,
                    child: const Text("COMPLETE RECIPE",
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}