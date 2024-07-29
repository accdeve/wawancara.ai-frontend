import 'package:flutter/material.dart';
import 'package:wawancara_ai/utils/colors.dart';
import 'package:wawancara_ai/utils/typography.dart';

class TextFieldwidget extends StatelessWidget {
  final String hintText;
  final Function(String) onChanged;
  final TextEditingController controller;
  final TextInputType keyboardType;

  const TextFieldwidget({
    super.key,
    required this.hintText,
    required this.onChanged,
    required this.controller,
    this.keyboardType = TextInputType.text, // Default value set to TextInputType.text
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      keyboardType: keyboardType, // Use the keyboardType parameter
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: overpassHint16,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: grey), // Border warna netral
          borderRadius: BorderRadius.circular(10), // Radius 10
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: primary), // Border warna utama
          borderRadius: BorderRadius.circular(10), // Radius 10
        ),
      ),
    );
  }
}
