import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:wawancara_ai/ui/screen/home/widget/nav_bar.dart';
import 'package:wawancara_ai/ui/screen/video/pertanyaan_custom_screen.dart';
import 'package:wawancara_ai/ui/screen/video/pertanyaan_umum_screen.dart';
import 'package:wawancara_ai/utils/colors.dart';

class ListVideoScreen extends StatefulWidget {
  static const routename = 'list_video_screen';

  const ListVideoScreen({super.key});

  @override
  State<ListVideoScreen> createState() => _ListVideoScreenState();
}

class _ListVideoScreenState extends State<ListVideoScreen> {
  int screenIndex = 0;
  bool sudahDijawab = true;
  bool belumDijawab = false;
  List pertanyaanSceen = [
    const PertanyaanUmumScreen(),
    const PertanyaanCustom(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        Navigator.pushReplacementNamed(context, Navbar.routename);
      },
      child: Scaffold(
          appBar: AppBar(
            leading: const SizedBox.shrink(),
            title: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: ToggleSwitch(
                    minWidth: 90.0,
                    cornerRadius: 20.0,
                    activeBgColors: const [
                      [primary],
                      [primary]
                    ],
                    activeFgColor: Colors.white,
                    inactiveBgColor: netral,
                    inactiveFgColor: Colors.white,
                    initialLabelIndex: screenIndex,
                    totalSwitches: 2,
                    labels: const ['Umum', 'Custom'],
                    radiusStyle: true,
                    onToggle: (index) {
                      setState(() {
                        screenIndex = index!;
                      });
                    },
                  ),
                ),
              ],
            ),
            centerTitle: true,
          ),
          body: pertanyaanSceen[screenIndex]),
    );
  }
}
