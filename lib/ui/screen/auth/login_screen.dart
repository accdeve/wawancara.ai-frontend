import 'package:flutter/material.dart';
import 'package:wawancara_ai/ui/screen/auth/register_screen.dart';
import 'package:wawancara_ai/ui/screen/home/widget/nav_bar.dart';
import 'package:wawancara_ai/ui/widget/button/primary_button.dart';
import 'package:wawancara_ai/utils/assets.dart';
import 'package:wawancara_ai/utils/colors.dart';
import 'package:wawancara_ai/utils/typography.dart';

class LoginScreen extends StatefulWidget {
  static const routename = "/login_screen";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
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
              const SizedBox(height: 48),
              const Text('Login Akun', style: overpassBlack2410),
              const Text(
                'Ayo masuk agar kamu dapat mulai simulasi wawancara kamu!',
                style: overpassSecondaryl16,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              // TextFieldwidget(
              //   hintText: 'Username*',
              //   onChanged: (value) {},
              // ),
              // const SizedBox(height: 24),
              // TextFieldwidget(
              //   hintText: 'Password*',
              //   onChanged: (value) {},
              // ),
              const SizedBox(height: 24),
              ButtonWidget(
                  text: "Masuk",
                  onPressed: () {
                    Navigator.pushNamed(context, Navbar.routename);
                  }),
              const SizedBox(height: 24),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 120.0,
                    child: Divider(
                      color: grey,
                    ),
                  ),
                  SizedBox(width: 20),
                  Text(
                    "or with",
                    style: overpassGrey16,
                  ),
                  SizedBox(width: 20),
                  SizedBox(
                    width: 120.0,
                    child: Divider(
                      color: grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Image.asset(logo_google, height: 50),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Belum punya akun?",
                    style: overpassGrey16,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, RegisterScreen.routename);
                    },
                    child: const Text(
                      " daftar",
                      style: TextStyle(color: primary, fontFamily: overpass, decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
