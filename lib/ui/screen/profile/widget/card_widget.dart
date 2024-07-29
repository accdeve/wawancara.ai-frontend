import 'package:flutter/material.dart';
import 'package:wawancara_ai/utils/typography.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({super.key, required this.jumlah, required this.pertanyaan});
  final int jumlah;
  final String pertanyaan;

  @override
  Widget build(BuildContext context) {
    final gradientColors = pertanyaan == "Pertanyaan custom"
        ? [
            const Color(0xFFFF71CD),
            const Color.fromARGB(255, 255, 177, 228)
          ] // Warna custom
        : [const Color(0xFF008FFF), const Color(0xFF00BFFF)]; // Warna default
    return Container(
      padding: const EdgeInsets.all(8),
      width: 200,
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(2, 2), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(),
          Text("$jumlah", style: overpassWhite2410),
          Text(pertanyaan, style: overpassWhite1610),
        ],
      ),
    );
  }
}
