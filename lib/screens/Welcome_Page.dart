import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});


  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD9E7E8), 
      body: Center(
        child: Container(
          width: 300, 
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
          child: Column(
            mainAxisSize: MainAxisSize.min, 
            children: [
              const Text(
                "WELCOME TO MY RECIPE BOOK",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2F696B),
                ),
              ),
              const SizedBox(height: 10), 
              const Text(
                "Start adding and exploring delicious recipes today!\n\n"
                "Tap the menu to add a new recipe or view your saved recipes.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
