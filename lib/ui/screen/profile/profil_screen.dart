// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wawancara_ai/data/cubit/profile/cubit/profile_cubit.dart';
import 'package:wawancara_ai/ui/screen/profile/widget/card_widget.dart';
import 'package:wawancara_ai/ui/screen/video/widget/score_video_widget.dart';
import 'package:wawancara_ai/utils/assets.dart';
import 'package:wawancara_ai/utils/extensions.dart';
import 'package:wawancara_ai/utils/typography.dart';

class ProfilScreen extends StatefulWidget {
  static const routename = 'profil_screen';
  const ProfilScreen({super.key});

  @override
  _ProfilScreenState createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().fetchProfileData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProfileFailure) {
            return const Center(child: Text('Error loading data'));
          } else if (state is ProfileSuccess) {
            final userData = state.data['userData'];
            final umumCount = state.data['umumCount'];
            final customCount = state.data['customCount'];
            final smileDetectionSum = state.data['smileDetectionSum'];
            final gazeDetectionSum = state.data['gazeDetectionSum'];
            final handDetectionSum = state.data['handDetectionSum'];
            final headDetectionSum = state.data['headDetectionSum'];

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Hai, Ini hasil kamu!",
                          style: overpassBlack2410,
                        ),
                        Image.asset(
                          logo,
                          height: 40,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      capitalize(userData['name']!),
                      style: overpassBlack247,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      capitalize(userData['job']!),
                      style: overpassSecondaryl16,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: [
                            CardWidget(jumlah: umumCount, pertanyaan: "Pertanyaan umum"),
                            const SizedBox(width: 20),
                            CardWidget(jumlah: customCount, pertanyaan: "Pertanyaan custom"),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      "Total",
                      style: overpassBlack2410,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ScoreWidget(
                            judul: "Senyum",
                            score: smileDetectionSum.toString(),
                            color: const Color(0xffEB5757),
                          ),
                          const SizedBox(width: 32),
                          ScoreWidget(
                            judul: "Tatapan",
                            score: gazeDetectionSum.toString(),
                            color: const Color(0xff4CD964),
                          ),
                          const SizedBox(width: 32),
                          ScoreWidget(
                            judul: "Tangan",
                            score: handDetectionSum.toString(),
                            color: const Color(0xffFFBE9D),
                          ),
                          const SizedBox(width: 32),
                          ScoreWidget(
                            judul: "Kepala",
                            score: headDetectionSum.toString(),
                            color: const Color(0xffFFBE9D),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
