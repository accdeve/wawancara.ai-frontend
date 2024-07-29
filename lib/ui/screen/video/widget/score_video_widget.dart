import 'package:flutter/material.dart';
import 'package:wawancara_ai/utils/typography.dart';

class ScoreWidget extends StatelessWidget {
  final String judul;
  final String score;
  final Color color;
  const ScoreWidget(
      {super.key,
      required this.judul,
      required this.score,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          judul,
          style: overpassGrey16,
        ),
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: color, width: 4),
            borderRadius: const BorderRadius.all(Radius.circular(100)),
          ),
          child: Center(
            child: Text(
              score,
              style: TextStyle(
                  fontSize: 20, color: color, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ],
    );
  }
}
