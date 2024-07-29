import 'dart:async';
import 'package:flutter/material.dart';
import 'package:wawancara_ai/ui/screen/video/take_video_screen.dart';
import 'package:wawancara_ai/utils/typography.dart';

class CountScreen extends StatefulWidget {
  static const routename = "count_screen";
  const CountScreen({super.key});

  @override
  State<CountScreen> createState() => _CountScreenState();
}

class _CountScreenState extends State<CountScreen> {
  var counting = ['Tiga', 'Dua', 'Satu', 'Mulai Rekaman'];
  int currentIndex = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      if (currentIndex < counting.length - 1) {
        setState(() {
          currentIndex++;
        });
      } else {
        _timer.cancel();
        Navigator.pushReplacementNamed(context, TakeVideoScreen.routename);
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Hentikan timer saat widget di dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          counting[currentIndex],
          textAlign: TextAlign.center,
          style: overpassBlack3010,
        ),
      ),
    );
  }
}
