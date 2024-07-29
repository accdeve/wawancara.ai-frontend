import 'package:flutter/material.dart';
import 'package:wawancara_ai/utils/typography.dart';

Widget walkthrought(String image, String judul, String deskripsi) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(image,height: 250,),
        const SizedBox(height: 10),
        Text(
          judul,
          style: overpassBlack3010,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(deskripsi,
              textAlign: TextAlign.center, style: overpassSecondary16),
        ),
      ],
    ),
  );
}
