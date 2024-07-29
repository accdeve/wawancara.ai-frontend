// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wawancara_ai/ui/screen/home/widget/nav_bar.dart';
import 'package:wawancara_ai/ui/widget/text_field/text_field_widget.dart';
import 'package:wawancara_ai/ui/widget/button/primary_button.dart';
import 'package:wawancara_ai/utils/typography.dart';

class RegisterScreen extends StatefulWidget {
  static const routename = "/register_screen";
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _jobController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _setWalkthroughComplete();
  }

  Future<void> _setWalkthroughComplete() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isHasWalkthrough', true);
  }

  Future<void> _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', _nameController.text);
    await prefs.setString('job', _jobController.text);
    Navigator.pushReplacementNamed(context, Navbar.routename);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        centerTitle: true,
        title: const Text(
          "Wawancara.ai",
          style: lalezarDarkBlue320,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const Text('Data Pribadi Kamu', style: overpassBlack2410),
              const Text(
                'Yuk buat data kamu biar kita saling kenal!',
                style: overpassSecondaryl16,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              TextFieldwidget(
                hintText: 'Name*',
                controller: _nameController,
                onChanged: (value) {
                  setState(() {});
                },
              ),
              const SizedBox(height: 24),
              TextFieldwidget(
                hintText: 'Pekerjaan yg dilamar*',
                controller: _jobController,
                onChanged: (value) {
                  setState(() {});
                },
              ),
              const SizedBox(height: 24),
              // TextFieldwidget(
              //   hintText: 'Username*',
              //   onChanged: (value) {},
              // ),
              // const SizedBox(height: 24),
              // TextFieldwidget(
              //   hintText: 'Password*',
              //   onChanged: (value) {},
              // ),
              // const SizedBox(height: 24),
              // TextFieldwidget(
              //   hintText: 'Confirm Password*',
              //   onChanged: (value) {},
              // ),
              // const SizedBox(height: 24),
              ButtonWidget(
                  text: "Simpan Data",
                  dataFilled: _nameController.text.isNotEmpty && _jobController.text.isNotEmpty ? true : false,
                  onPressed: () async {
                    _saveData();
                  }),
              const SizedBox(height: 8),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     const Text(
              //       "Sudah punya akun?",
              //       style: overpassGrey16,
              //     ),
              //     GestureDetector(
              //       onTap: () {
              //         Navigator.pushNamed(context, LoginScreen.routename);
              //       },
              //       child: const Text(
              //         " masuk",
              //         style: TextStyle(color: primary, fontFamily: overpass, decoration: TextDecoration.underline),
              //       ),
              //     ),
              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }
}
