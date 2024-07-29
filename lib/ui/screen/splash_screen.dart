// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:wawancara_ai/ui/screen/home/widget/nav_bar.dart';
import 'package:wawancara_ai/ui/screen/walkthrough/walkthrough_screen.dart';
import 'package:wawancara_ai/utils/assets.dart';
import 'package:wawancara_ai/utils/typography.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatelessWidget {
  static const routename = "splash_screen";
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? name = prefs.getString('name');

      name != null ? Navigator.pushReplacementNamed(context, Navbar.routename) : Navigator.pushReplacementNamed(context, Walkthrough.routename);
    });
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                logo,
                height: 30,
              ),
              const Text(
                "Wawancara.ai",
                style: lalezarDarkBlue320,
              ),
            ],
          ),
          Stack(
            children: <Widget>[
              Image.asset(
                img_version,
                height: 80,
              ),
              const Positioned.fill(
                child: Center(
                  child: Text("v.1.0.0", style: lalezarWhite240),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
