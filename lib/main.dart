// ignore_for_file: library_prefixes

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wawancara_ai/data/bloc/videos/bloc/videos_bloc.dart';
import 'package:wawancara_ai/data/cubit/detection/cubit/detection_cubit.dart';
import 'package:wawancara_ai/data/cubit/pertanyaan/cubit/pertanyaan_cubit.dart';
import 'package:wawancara_ai/data/cubit/profile/cubit/profile_cubit.dart';
import 'package:wawancara_ai/db/database_helper.dart';
import 'package:wawancara_ai/ui/screen/auth/welcome.dart';
import 'package:wawancara_ai/ui/screen/splash_screen.dart';
import 'package:wawancara_ai/ui/screen/video/detail_video_screen.dart';
import 'package:wawancara_ai/ui/screen/video/pertanyaan_umum_screen.dart';
import 'package:wawancara_ai/ui/screen/video/pertanyaan_video.dart';
import 'package:wawancara_ai/ui/screen/auth/login_screen.dart';
import 'package:wawancara_ai/ui/screen/walkthrough/walkthrough_screen.dart';
import 'package:wawancara_ai/ui/screen/home/home_screen.dart';
import 'package:wawancara_ai/ui/screen/auth/register_screen.dart';
import 'package:wawancara_ai/ui/screen/home/widget/nav_bar.dart';
import 'package:wawancara_ai/ui/screen/profile/profil_screen.dart';
import 'package:wawancara_ai/ui/screen/video/countdown_screen.dart';
import 'package:wawancara_ai/ui/screen/video/take_video_screen.dart';
import 'env/env.dart' as AppEnv;

// ignore: unused_element
late List<CameraDescription> _cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  try {
    _cameras = await availableCameras();
  } catch (error) {
    debugPrint(error as String?);
  }
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (context) => PertanyaanCubit(),
      child: const PertanyaanUmumScreen(),
    ),
    BlocProvider(
      create: (context) => PertanyaanCubit(),
      child: const TakeVideoScreen(),
    ),
    BlocProvider(
      create: (context) => VideosBloc(),
      child: const TakeVideoScreen(),
    ),
    BlocProvider(
      create: (context) => DetectionCubit(),
      child: const HomeScreen(),
    ),
    BlocProvider(
      create: (context) => DetectionCubit(),
      child: const VideoPlayerScreen(
        videoId: '',
      ),
    ),
    BlocProvider(
      create: (context) => ProfileCubit(DatabaseHelper()),
      child: const ProfilScreen(),
    ),
    BlocProvider(
      create: (context) => VideosBloc(),
      child: const HomeScreen(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.routename,
      routes: {
        SplashScreen.routename: (context) => const SplashScreen(),
        Walkthrough.routename: (context) => const Walkthrough(),
        WelcomeScreen.routename: (context) => const WelcomeScreen(),
        LoginScreen.routename: (context) => const LoginScreen(),
        RegisterScreen.routename: (context) => const RegisterScreen(),
        Navbar.routename: (context) => const Navbar(),
        HomeScreen.routename: (context) => const HomeScreen(),
        ListVideoScreen.routename: (context) => const ListVideoScreen(),
        ProfilScreen.routename: (context) => const ProfilScreen(),
        CountScreen.routename: (context) => const CountScreen(),
        TakeVideoScreen.routename: (context) => const TakeVideoScreen(),
      },
    );
  }
}

class Config {
  static const String baseUrl = kDebugMode ? AppEnv.BASE_URL : AppEnv.BASE_URL;
  static const String adsKey = kDebugMode ? AppEnv.KEY : AppEnv.KEY;
}
