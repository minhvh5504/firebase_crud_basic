import 'package:flutter/material.dart';

class ButtonCustom extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const ButtonCustom({super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.amber.shade300,
        foregroundColor: Colors.cyanAccent,
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
      ),
      child: Text(
        title,
        style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}
