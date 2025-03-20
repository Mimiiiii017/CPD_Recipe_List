import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../services/firebase.dart';

class AddRecipeScreen extends StatefulWidget {
  const AddRecipeScreen({super.key});

  @override
  State<AddRecipeScreen> createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final _formKey = GlobalKey<FormState>();

  final recipeNameController = TextEditingController();
  final categoryController = TextEditingController();
  final ingredientsController = TextEditingController();
  final instructionsController = TextEditingController();
  final prepTimeController = TextEditingController();
  final cookTimeController = TextEditingController();
  final servingsController = TextEditingController();
  final descriptionController = TextEditingController();

  File? selectedImage;
  String? uploadedImageUrl;

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> showNotification(String recipeName) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'recipe_channel',
      'Recipe Notifications',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.show(
      0,
      'New Recipe Added!',
      'New recipe added: $recipeName',
      notificationDetails,
    );
  }

  void submitRecipe() async {
    if (_formKey.currentState!.validate()) {
      try {
        String? imageUrl;

        if (selectedImage != null) {
          String fileName = 'recipes/${DateTime.now().millisecondsSinceEpoch}.jpg';
          Reference storageRef = FirebaseStorage.instance.ref().child(fileName);

          // Delete previous image if exists
          if (uploadedImageUrl != null && uploadedImageUrl!.isNotEmpty) {
            await FirebaseStorage.instance.refFromURL(uploadedImageUrl!).delete();
          }

          await storageRef.putFile(selectedImage!);
          imageUrl = await storageRef.getDownloadURL();
        }

        await FirebaseService.addRecipe(
          recipeName: recipeNameController.text,
          category: categoryController.text,
          ingredients: ingredientsController.text.split(","),
          instructions: instructionsController.text.split(","),
          prepTime: prepTimeController.text,
          cookTime: cookTimeController.text,
          description: descriptionController.text,
          imageUrl: imageUrl,
        );

        showNotification(recipeNameController.text);

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
      appBar: AppBar(
        backgroundColor: const Color(0xFF2F696B),
        title: const Text('Add Recipe Form', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
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
                  const Text(
                    "ADD RECIPE",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color(0xFF2F696B),
                        fontSize: 24,
                        fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(height: 20),
                TextFormField(
                    controller: recipeNameController,
                    decoration: const InputDecoration(
                        labelText: "Recipe Name",
                        labelStyle:
                            TextStyle(fontSize: 14, color: Color(0xFF626262)),
                        border: OutlineInputBorder()),
                    validator: (val) =>
                        val!.isEmpty ? "Enter a recipe name" : null,
                  ),

                  const SizedBox(height: 15),

                  TextFormField(
                    controller: categoryController,
                    decoration: const InputDecoration(
                        labelText: "Category",
                        labelStyle:
                            TextStyle(fontSize: 14, color: Color(0xFF626262)),
                        border: OutlineInputBorder()),
                    validator: (val) =>
                        val!.isEmpty ? "Enter category" : null,
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
                        labelStyle:
                            TextStyle(fontSize: 14, color: Color(0xFF626262)),
                        border: OutlineInputBorder()),
                    validator: (val) => val!.isEmpty ? "Enter Prep Time" : null,
                  ),

                  const SizedBox(height: 15),

                  TextFormField(
                    controller: cookTimeController,
                    decoration: const InputDecoration(
                        labelText: "Cook Time",
                        labelStyle:
                            TextStyle(fontSize: 14, color: Color(0xFF626262)),
                        border: OutlineInputBorder()),
                    validator: (val) => val!.isEmpty ? "Enter Cook Time" : null,
                  ),

                  const SizedBox(height: 15),

                  TextFormField(
                    controller: descriptionController,
                    decoration: const InputDecoration(
                        labelText: "Description",
                        labelStyle:
                            TextStyle(fontSize: 14, color: Color(0xFF626262)),
                        border: OutlineInputBorder()),
                    validator: (val) => val!.isEmpty ? "Enter Description" : null,
                  ),

                const SizedBox(height: 15),
                OutlinedButton.icon(
                  onPressed: () async {
                    final picker = ImagePicker();
                    final pickedImage = await picker.pickImage(source: ImageSource.camera);
                    if (pickedImage != null) {
                      setState(() => selectedImage = File(pickedImage.path));
                    }
                  },
                  icon: const Icon(Icons.camera_alt, color: Color(0xFF2F696B)),
                  label: const Text("Take Photo", style: TextStyle(color: Color(0xFF2F696B))),
                  style: OutlinedButton.styleFrom(
                    fixedSize: const Size.fromHeight(100),
                    side: const BorderSide(color: Color(0xFF2F696B)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2F696B),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  onPressed: submitRecipe,
                  child: const Text("COMPLETE RECIPE", style: TextStyle(color: Colors.white)),
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
