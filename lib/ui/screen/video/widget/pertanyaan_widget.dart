import 'package:flutter/material.dart';
import 'package:wawancara_ai/utils/assets.dart';
import 'package:wawancara_ai/utils/typography.dart';

class PertanyaanWidget extends StatelessWidget {
  final String judul;
  final String deskripsi;
  const PertanyaanWidget({super.key, required this.judul, required this.deskripsi});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              img_walkthrough_1,
              height: 250,
            ),
            Text(
              judul,
              style: overpassBlack3010,
              textAlign: TextAlign.center,
            ),
        
            // const SizedBox(height: 65),
            const SizedBox(height: 20),
            Text(
              deskripsi,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, color: Colors.black.withOpacity(0.3)),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
