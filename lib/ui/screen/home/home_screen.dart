import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import 'package:wawancara_ai/data/bloc/videos/bloc/videos_bloc.dart';
import 'package:wawancara_ai/ui/screen/video/detail_video_screen.dart';
import 'package:wawancara_ai/utils/assets.dart';
import 'package:wawancara_ai/utils/extensions.dart';
import 'package:wawancara_ai/utils/typography.dart';

class HomeScreen extends StatefulWidget {
  static const routename = "home_screen";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String nama = "";
  bool isSelectionMode = false;

  Future<String?> getNama() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('name');
  }

  @override
  void initState() {
    super.initState();
    getNama().then((value) {
      if (mounted) {
        setState(() {
          nama = value ?? '';
        });
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (context.read<VideosBloc>().state is! VideosLoaded) {
      context.read<VideosBloc>().add(FetchVideos());
    }
  }

  // @override
  // void dispose() {
  //   if (mounted) {
  //     final state = context.read<VideosBloc>().state;
  //     if (state is VideosLoaded) {
  //       for (var controller in state.controllers) {
  //         controller.dispose();
  //       }
  //     }
  //   }
  //   super.dispose();
  // }

  void _toggleSelectionMode() {
    setState(() {
      isSelectionMode = !isSelectionMode;
      if (!isSelectionMode) {
        context.read<VideosBloc>().add(SelectVideo(null, clearSelection: true));
      }
    });
  }

  void _onDeleteSelectedVideos() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi Hapus'),
        content: const Text('Apakah Anda yakin ingin menghapus video ini?'),
        actions: [
          TextButton(
            onPressed: () {
              context.read<VideosBloc>().add(DeleteSelectedVideos());
              Navigator.of(context).pop();
            },
            child: const Text('Hapus'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Batal'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Transform.scale(
          scale: 0.5,
          child: Image.asset(
            logo,
            height: 2,
            width: 2,
          ),
        ),
        actions: [
          isSelectionMode
              ? Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: _toggleSelectionMode,
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: _onDeleteSelectedVideos,
                    ),
                  ],
                )
              : const SizedBox()
        ],
        title: Text(
          "Hai $nama, Ayo latihan!",
          style: overpassBlack2410,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocBuilder<VideosBloc, VideosState>(
          builder: (context, state) {
            if (state is VideosLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is VideosLoaded) {
              return state.videos.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(img_walkthrough_2, height: 150),
                          const Text(
                            "Video kamu masih kosong, ayo buat video!",
                            style: overpassHint16,
                          ),
                        ],
                      ),
                    )
                  : Column(
                      children: [
                        const SizedBox(height: 12),
                        Expanded(
                          child: GridView.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 20.0, mainAxisSpacing: 20.0, childAspectRatio: 0.8),
                            itemCount: state.videos.length,
                            itemBuilder: (context, index) {
                              final video = state.videos[index];
                              final isSelected = state.selectedVideos.contains(video);
                              final controller = state.controllers[index];

                              return GestureDetector(
                                onLongPress: () {
                                  context.read<VideosBloc>().add(SelectVideo(video));
                                  _toggleSelectionMode();
                                },
                                onTap: () {
                                  if (isSelectionMode) {
                                    context.read<VideosBloc>().add(SelectVideo(video));
                                  } else {
                                    pushScreen(
                                      context,
                                      VideoPlayerScreen(videoId: video.id),
                                    );
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: isSelected ? Colors.blue : Colors.transparent,
                                      width: 3,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          controller.value.isInitialized
                                              ? ClipRRect(
                                                  borderRadius: BorderRadius.circular(10),
                                                  child: SizedBox(
                                                    width: double.infinity,
                                                    height: 150,
                                                    child: AspectRatio(
                                                      aspectRatio: controller.value.aspectRatio,
                                                      child: VideoPlayer(controller),
                                                    ),
                                                  ),
                                                )
                                              : Container(
                                                  width: double.infinity,
                                                  height: 150,
                                                  color: Colors.grey[300],
                                                  child: const Center(child: CircularProgressIndicator()),
                                                ),
                                          const Icon(
                                            Icons.play_circle_outline,
                                            size: 50,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                truncateText(video.title, 3),
                                                style: overpassBlack1210,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            RichText(
                                              text: TextSpan(
                                                children: [
                                                  const WidgetSpan(
                                                    child: Icon(Icons.timer, size: 16),
                                                  ),
                                                  TextSpan(
                                                    text: video.duration.toString(),
                                                    style: overpassGrey16,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
            } else if (state is VideosError) {
              return const Center(child: Text(""));
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
