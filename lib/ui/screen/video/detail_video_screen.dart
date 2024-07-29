// ignore_for_file: library_private_types_in_public_api

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:wawancara_ai/data/cubit/detection/cubit/detection_cubit.dart';
import 'package:wawancara_ai/data/models/pertanyaan_umum.dart';
import 'package:wawancara_ai/data/models/video.dart';
import 'package:wawancara_ai/db/database_helper.dart';
import 'package:wawancara_ai/ui/screen/video/widget/score_video_widget.dart';
import 'package:wawancara_ai/ui/widget/button/primary_button.dart';
import 'package:wawancara_ai/utils/typography.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String videoId;

  const VideoPlayerScreen({super.key, required this.videoId});

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;
  bool _isfullScreen = false;
  Video? videoData;
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadVideoData();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _loadVideoData() async {
    videoData = await _databaseHelper.getVideoById(widget.videoId);
    if (videoData != null) {
      _initializeVideoPlayer(videoData!.fileName);
    }
    setState(() {});
  }

  Future<void> _initializeVideoPlayer(String fileName) async {
    _controller = VideoPlayerController.file(File(fileName));
    await _controller.initialize();
    setState(() {});
  }

  List<String>? getJawabanAlternatif(String title) {
    for (var pertanyaan in pertanyaanUmum) {
      if (pertanyaan.pertanyaan == title) {
        return pertanyaan.jawabanAlternatif;
      }
    }
    return null;
  }

  void uploadVideo() async {
    setState(() {
      _isLoading = true;
    });

    List<File> filesToUpload = [File(videoData!.fileName)];

    context.read<DetectionCubit>().uploadFiles(
          'detection',
          videoData!.id,
          filesToUpload,
        );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Video Detail',
          style: overpassGreyBlack2010,
        ),
        centerTitle: true,
        leading: const SizedBox(),
      ),
      body: BlocListener<DetectionCubit, DetectionState>(
        listener: (context, state) {
          if (state is DetectionLoading) {
            setState(() {
              _isLoading = true;
            });
          } else if (state is DetectionSuccess) {
            setState(() {
              _isLoading = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Video berhasil di deteksi!'),
                backgroundColor: Colors.blueGrey[900],
                behavior: SnackBarBehavior.floating,
              ),
            );
            // Reload video data to update UI
            _loadVideoData();
          } else if (state is DetectionError) {
            setState(() {
              _isLoading = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        child: Stack(
          children: [
            Opacity(
              opacity: _isLoading ? 0.5 : 1.0,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: videoData == null
                    ? const Center(child: CircularProgressIndicator())
                    : SingleChildScrollView(
                        child: Column(
                          children: [
                            _controller.value.isInitialized
                                ? AnimatedContainer(
                                    duration: const Duration(milliseconds: 50),
                                    width: screenWidth,
                                    height: _isfullScreen ? 650 : 320,
                                    decoration: BoxDecoration(
                                      color: !_isfullScreen ? Colors.black : null,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: <Widget>[
                                        SizedBox(
                                          width: _isfullScreen ? 360 : 180,
                                          height: _isfullScreen ? 640 : 320,
                                          child: VideoPlayer(_controller),
                                        ),
                                        IconButton(
                                          icon: Icon(
                                            Icons.play_circle_outline,
                                            size: 100,
                                            color: _isPlaying ? Colors.transparent : Colors.white,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              if (_controller.value.isPlaying) {
                                                _controller.pause();
                                                _isPlaying = false;
                                              } else {
                                                _controller.play();
                                                _isPlaying = true;
                                              }
                                            });
                                          },
                                        ),
                                        Positioned(
                                          bottom: 10,
                                          right: 20,
                                          child: IconButton(
                                            icon: _isfullScreen ? const Icon(Icons.fullscreen_exit) : const Icon(Icons.fullscreen),
                                            color: Colors.white,
                                            onPressed: () {
                                              setState(() {
                                                _isfullScreen = !_isfullScreen;
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : const CircularProgressIndicator(),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: screenWidth / 2,
                                  child: Text(videoData!.title, style: overpassBlack1210),
                                ),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      const WidgetSpan(
                                        child: Icon(Icons.timer, size: 16), // Icon timer
                                      ),
                                      TextSpan(text: videoData!.duration.toString(), style: overpassGrey16),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            const SizedBox(
                              width: double.infinity,
                              child: Text(
                                "Score",
                                style: overpassBlack247,
                              ),
                            ),
                            const SizedBox(height: 10),
                            videoData!.hasDetection == 1
                                ? SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        ScoreWidget(
                                          judul: "Senyum",
                                          score: videoData!.smileDetection.toString(),
                                          color: const Color(0xffFFBE9D),
                                        ),
                                        const SizedBox(width: 32),
                                        ScoreWidget(
                                          judul: "Tangan",
                                          score: videoData!.handDetection.toString(),
                                          color: const Color(0xff4CD964),
                                        ),
                                        const SizedBox(width: 32),
                                        ScoreWidget(
                                          judul: "Tatapan",
                                          score: videoData!.gazeDetection.toString(),
                                          color: const Color(0xffEB5757),
                                        ),
                                        const SizedBox(width: 32),
                                        ScoreWidget(
                                          judul: "Anggukan",
                                          score: videoData!.headDetection.toString(),
                                          color: const Color(0xffFFBE9D),
                                        ),
                                      ],
                                    ),
                                  )
                                : ButtonWidget(
                                    onPressed: () {
                                      uploadVideo();
                                    },
                                    text: "Deteksi dengan AI",
                                    dataFilled: true,
                                  ),
                            const SizedBox(height: 20),
                            const SizedBox(
                              width: double.infinity,
                              child: Text(
                                "Option Answer",
                                style: overpassBlack247,
                              ),
                            ),
                            const SizedBox(height: 10),
                            getJawabanAlternatif(videoData!.title) != null
                                ? Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: List.generate(getJawabanAlternatif(videoData!.title)!.length, (index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(bottom: 10.0),
                                        child: Text(
                                          "${index + 1}. ${getJawabanAlternatif(videoData!.title)![index]}",
                                          style: overpassHint12,
                                        ),
                                      );
                                    }),
                                  )
                                : const Row(
                                    children: [
                                      Text(
                                        'Pertanyaan custom tidak tersedia saran jawaban!',
                                        style: overpassHint12,
                                      ),
                                    ],
                                  ),
                          ],
                        ),
                      ),
              ),
            ),
            if (_isLoading)
              Center(
                child: Container(
                  color: Colors.grey.withOpacity(0.5),
                  child: const CircularProgressIndicator(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
