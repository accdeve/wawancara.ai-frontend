import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wawancara_ai/ui/screen/video/pertanyaan_video.dart';
import 'package:wawancara_ai/ui/screen/home/home_screen.dart';
import 'package:wawancara_ai/ui/screen/profile/profil_screen.dart';
import 'package:wawancara_ai/utils/colors.dart';

class Navbar extends StatefulWidget {
  static const routename = "navbar";
  const Navbar({Key? key}) : super(key: key);

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  List screen = [
    const HomeScreen(),
    const ListVideoScreen(),
    const ProfilScreen(),
  ];
  int _selectedscreen = 0;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Konfirmasi'),
            content: const Text('Apakah Anda yakin ingin keluar dari aplikasi?'),
            actions: [
              TextButton(
                onPressed: () {
                  SystemNavigator.pop();
                },
                child: const Text('Ya'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false); // Stay in the app
                },
                child: const Text('Tidak'),
              ),
            ],
          ),
        );
      },
      child: Scaffold(
        body: screen[_selectedscreen],
        bottomNavigationBar: _selectedscreen == 1
            ? null
            : BottomNavigationBar(
              selectedItemColor: primary,
                items: const [
                  BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                  BottomNavigationBarItem(icon: Icon(Icons.add), label: "Add"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person), label: "profil"),
                ],
                currentIndex: _selectedscreen,
                onTap: (value) {
                  setState(() {
                    _selectedscreen = value;
                  });
                },
              ),
      ),
    );
  }
}
