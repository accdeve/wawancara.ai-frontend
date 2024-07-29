import 'package:flutter/material.dart';
import 'package:wawancara_ai/utils/colors.dart';
import 'package:wawancara_ai/utils/typography.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool dataFilled;
  final bool loading;

  const ButtonWidget({
    super.key,
    this.text = '',
    required this.onPressed,
    this.dataFilled = false,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    Color buttonColor;

    if (loading) {
      buttonColor = primary;
    } else if (dataFilled) {
      buttonColor = primary;
    } else {
      buttonColor = Colors.grey;
    }

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        onPressed: (loading || !dataFilled) ? null : onPressed,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: loading
              ? const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                )
              : Text(
                  text,
                  style: overpassWhite1610, // Teks berwarna putih
                ),
        ),
      ),
    );
  }
}
