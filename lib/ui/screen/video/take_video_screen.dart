// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:wawancara_ai/data/bloc/videos/bloc/videos_bloc.dart';
import 'package:wawancara_ai/data/cubit/pertanyaan/cubit/pertanyaan_cubit.dart';
import 'package:wawancara_ai/data/models/video.dart';
import 'package:wawancara_ai/db/database_helper.dart';
import 'package:wawancara_ai/ui/screen/home/widget/nav_bar.dart';
import 'package:wawancara_ai/utils/assets.dart';
import 'package:wawancara_ai/utils/typography.dart';

class TakeVideoScreen extends StatefulWidget {
  static const routename = 'take_video_screen';
  const TakeVideoScreen({super.key}); // Fix syntax error

  @override
  TakeVideoScreenState createState() => TakeVideoScreenState();
}

class TakeVideoScreenState extends State<TakeVideoScreen> {
  late CameraController _cameraController;
  late List<CameraDescription> _cameras;
  bool _isCameraInitialized = false;
  late String fileName;
  late Timer _timer;
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  File? _videoFile;
  int durasi = 60;
  int angkaDurasi = 0;
  String pertanyaan = "kosong";
  String type = "umum";

  late VideoPlayerController _videoPlayerController;
  late Future<void> _videoPlayerInitializer;

  @override
  void initState() {
    super.initState();
    _initializeCamera().then((_) {
      _startRecording();
      _startTimer();
    });

    final random = Random();
    int angkaacak = random.nextInt(2);

    final cubit = BlocProvider.of<PertanyaanCubit>(context);
    final state = cubit.state;
    durasi = state.durasi;
    angkaDurasi = state.durasi;
    pertanyaan = state.pertanyaan;
    type = state.type;

    _videoPlayerController = VideoPlayerController.asset(angkaacak == 0 ? video_timpa_fail : video_timpa_fifi);
    _videoPlayerInitializer = _videoPlayerController.initialize();
    _videoPlayerController.play();
  }

  Future<void> _initializeCamera() async {
    _cameras = await availableCameras();
    _cameraController = CameraController(
      _cameras[1],
      ResolutionPreset.low,
    );

    await _cameraController.initialize();
    setState(() {
      _isCameraInitialized = true;
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (durasi > 0) {
          durasi--;
        } else {
          _timer.cancel();
          _stopRecordingAndSave();
        }
      });
    });
  }

  void _startRecording() async {
    if (!_isCameraInitialized || !_cameraController.value.isInitialized) {
      return;
    }

    try {
      final directory = await getTemporaryDirectory();
      fileName = '${directory.path}/video_test_${DateTime.now().millisecondsSinceEpoch}.mp4';
      await _cameraController.startVideoRecording();
    } catch (e) {
      debugPrint('Failed to start video recording: $e');
      return;
    }
  }

  void _stopRecordingAndSave() async {
    if (!_isCameraInitialized || !_cameraController.value.isRecordingVideo) {
      return;
    }

    try {
      final XFile videoFile = await _cameraController.stopVideoRecording();
      _videoFile = File(videoFile.path);

      final newVideo = Video(id: DateTime.now().toString(), title: pertanyaan, fileName: _videoFile!.path, duration: angkaDurasi, smileDetection: 0, gazeDetection: 0, handDetection: 0, headDetection: 0, type: type, hasDetection: 0);

      _databaseHelper.insertVideo(newVideo);

      context.read<VideosBloc>().add(AddVideo(newVideo));

      Navigator.pushReplacementNamed(context, Navbar.routename);
    } catch (e) {
      debugPrint('Failed to stop video recording: $e');
    }
  }

  @override
  void dispose() {
    _cameraController.dispose();
    _videoPlayerController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Konfirmasi'),
            content: const Text('Apakah Anda yakin ingin keluar dari halaman rekaman?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, Navbar.routename); // Exit the screen
                },
                child: const Text('Ya'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false); // Stay on the screen
                },
                child: const Text('Tidak'),
              ),
            ],
          ),
        );
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        pertanyaan,
                        style: overpassBlack247,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Text(
                      "$durasi",
                      style: overpassBlack3010,
                    )
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Stack(
                  children: [
                    SizedBox(
                      width: 360,
                      height: 640,
                      child: FutureBuilder(
                        future: _videoPlayerInitializer,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done) {
                            return AspectRatio(
                              aspectRatio: _videoPlayerController.value.aspectRatio,
                              child: VideoPlayer(_videoPlayerController),
                            );
                          } else {
                            return Container(
                              color: Colors.green,
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
