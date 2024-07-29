import 'package:flutter/material.dart';
import 'package:wawancara_ai/ui/screen/auth/register_screen.dart';
import 'package:wawancara_ai/ui/widget/button/primary_button.dart';
import 'package:wawancara_ai/utils/assets.dart';
import 'package:wawancara_ai/utils/typography.dart';

class WelcomeScreen extends StatelessWidget {
  static const routename = "welcome_screen";
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Image.asset(
                img_walkthrough_3,
                height: 250,
              ),
              const Text(
                "Selamat datang di Wawancara.ai",
                style: overpassBlack2410,
              ),
              const Text(
                "Simulasi, solusi untuk latihan wawancara!",
                style: overpassSecondaryl16,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ButtonWidget(
            text: 'Masuk',
            dataFilled: true,
            onPressed: () {
              Navigator.pushNamed(context, RegisterScreen.routename);
            }),
      ),
    );
  }
}
