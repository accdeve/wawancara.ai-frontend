import 'package:flutter/material.dart';
import 'package:wawancara_ai/utils/colors.dart';
import 'package:wawancara_ai/utils/typography.dart';

class SecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  SecondaryButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: netral, 
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25), 
          ),
        ),
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text,
            style: overpassHint16,
          ),
        ),
      ),
    );
  }
}
