import 'package:flutter/material.dart';
import 'package:wawancara_ai/ui/screen/auth/welcome.dart';
import 'package:wawancara_ai/utils/assets.dart';
import 'package:wawancara_ai/utils/colors.dart';
import 'package:wawancara_ai/ui/screen/walkthrough/widget/walkthrough_widget.dart';

class Walkthrough extends StatefulWidget {
  const Walkthrough({super.key});
  static const routename = "walkthrough_screen";

  @override
  State<Walkthrough> createState() => _WalkthroughState();
}

class _WalkthroughState extends State<Walkthrough> {
  late PageController _pageController;
  int imageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: imageIndex);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(right: 20, left: 20, bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                height: 40,
              ),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      imageIndex = index;
                    });
                  },
                  children: [
                    walkthrought(
                        img_walkthrough_1,
                        'Train your answer in interview',
                        'Posisikan hanphone selayaknya sedang video call. Dengan anggapan bahwa kamu sedang berhadapan dengan pewawancara!'),
                    walkthrought(
                        img_walkthrough_4,
                        'Feel the real situation in interview',
                        'Rasakan situasi face to face dengan pewawancara terhadap kamu agar kamu terbiasa menghadapi situasi tersebut!'),
                    walkthrought(
                        img_walkthrough_3,
                        'The application will evaluate your gesture',
                        'Aplikasi akan mendeteksi gesture kamu untuk memberikan mu penilaian agar kamu dapat menjadi lebih baik'),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, WelcomeScreen.routename);
                      },
                      child: Text(
                        'Skip',
                        style: TextStyle(
                            color: const Color(0xff090F47).withOpacity(0.45)),
                      ),
                    ),
                    SizedBox(
                      width: 30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          for (int i = 0; i < 3; i++)
                            Container(
                              width: 5,
                              height: 5,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: i == imageIndex
                                    ? const Color(0xff4157FF)
                                    : const Color(0xffC4C4C4),
                              ),
                            ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if (imageIndex < 2) {
                          _pageController.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease);
                        } else {
                          Navigator.pushNamed(context, WelcomeScreen.routename);
                        }
                      },
                      child: const Text(
                        'Next',
                        style: TextStyle(
                            color: primary, fontFamily: 'Overpass-Bold'),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
