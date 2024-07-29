import 'package:flutter/material.dart';
import 'package:wawancara_ai/data/cubit/pertanyaan/cubit/pertanyaan_cubit.dart';
import 'package:wawancara_ai/data/models/pertanyaan_umum.dart';
import 'package:wawancara_ai/ui/screen/video/countdown_screen.dart';
import 'package:wawancara_ai/ui/screen/video/widget/pertanyaan_widget.dart';
import 'package:wawancara_ai/ui/widget/button/primary_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PertanyaanUmumScreen extends StatefulWidget {
  static const routename = 'list_video_screen';

  const PertanyaanUmumScreen({super.key});

  @override
  State<PertanyaanUmumScreen> createState() => _PertanyaanUmumScreenState();
}

class _PertanyaanUmumScreenState extends State<PertanyaanUmumScreen> {
  late PageController _pageController;

  int imageIndex = 0;
  bool sudahDijawab = true;
  bool belumDijawab = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: imageIndex);
  }

  List<PertanyaanWidget> childrenPertanyaan() {
    return pertanyaanUmum.map((pertanyaan) => PertanyaanWidget(judul: pertanyaan.pertanyaan, deskripsi: pertanyaan.deskripsi)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PertanyaanCubit(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Stack(
            children: [
              PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      imageIndex = index;
                    });
                  },
                  children: childrenPertanyaan()),
              Positioned(
                top: MediaQuery.of(context).size.height / 3.4,
                left: 0,
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      if (imageIndex > 0) {
                        imageIndex -= 1;
                        _pageController.animateToPage(imageIndex, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
                      }
                    });
                  },
                  icon: imageIndex == 0 ? const SizedBox() : const Icon(Icons.arrow_back_ios_new_rounded),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height / 3.4,
                right: 0,
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      if (imageIndex < pertanyaanUmum.length) {
                        imageIndex += 1;
                        _pageController.animateToPage(imageIndex, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
                      }
                    });
                  },
                  icon: imageIndex == pertanyaanUmum.length - 1 ? const SizedBox() : const Icon(Icons.arrow_forward_ios_rounded),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
          child: ButtonWidget(
              dataFilled: true,
              text: "Mulai",
              onPressed: () {
                context.read<PertanyaanCubit>().updatePertanyaanAndDurasi(pertanyaanUmum[imageIndex].pertanyaan, 20, "umum");
                Navigator.pushNamed(context, CountScreen.routename);
              }),
        ),
      ),
    );
  }
}
