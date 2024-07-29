import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:video_player/video_player.dart';
import 'package:wawancara_ai/data/models/video.dart';
import 'package:wawancara_ai/db/database_helper.dart';

part 'videos_event.dart';
part 'videos_state.dart';

class VideosBloc extends Bloc<VideosEvent, VideosState> {
  bool _videosLoaded = false; // Flag to check if videos have been loaded

  VideosBloc() : super(VideosInitial()) {
    on<FetchVideos>(_onFetchVideos);
    on<SelectVideo>(_onSelectVideo);
    on<DeleteSelectedVideos>(_onDeleteSelectedVideos);
    on<AddVideo>(_onAddVideo);
  }

  Future<void> _onFetchVideos(FetchVideos event, Emitter<VideosState> emit) async {
    if (_videosLoaded && !event.forceRefresh) return;

    emit(VideosLoading());

    try {
      List<Video> fetchedVideos = await DatabaseHelper().getAllVideos();
      List<VideoPlayerController> controllers = fetchedVideos.map((video) => VideoPlayerController.file(File(video.fileName))).toList();
      for (var controller in controllers) {
        await controller.initialize();
      }

      _videosLoaded = true; // Mark videos as loaded
      emit(VideosLoaded(fetchedVideos, controllers));
    } catch (e) {
      emit(VideosError('Failed to fetch videos: $e'));
    }
  }

void _onSelectVideo(SelectVideo event, Emitter<VideosState> emit) {
  if (state is VideosLoaded) {
    final currentState = state as VideosLoaded;
    final selectedVideos = List<Video>.from(currentState.selectedVideos);

    if (event.clearSelection) {
      // Clear all selections
      selectedVideos.clear();
    } else if (event.video != null) {
      if (selectedVideos.contains(event.video)) {
        // Deselect video
        selectedVideos.remove(event.video);
      } else {
        // Select video
        selectedVideos.add(event.video!);
      }
    }

    emit(VideosLoaded(currentState.videos, currentState.controllers, selectedVideos: selectedVideos));
  }
}


  Future<void> _onDeleteSelectedVideos(DeleteSelectedVideos event, Emitter<VideosState> emit) async {
    if (state is VideosLoaded) {
      final currentState = state as VideosLoaded;
      final dbHelper = DatabaseHelper();
      for (var video in currentState.selectedVideos) {
        await dbHelper.deleteVideo(video.id);
        currentState.controllers[currentState.videos.indexOf(video)].dispose();
      }
      final remainingVideos = currentState.videos.where((video) => !currentState.selectedVideos.contains(video)).toList();
      final remainingControllers = remainingVideos.map((video) => VideoPlayerController.file(File(video.fileName))).toList();
      for (var controller in remainingControllers) {
        await controller.initialize();
      }

      _videosLoaded = false; // Reset the flag to allow fetching updated videos
      emit(VideosLoaded(remainingVideos, remainingControllers));
      add(FetchVideos(forceRefresh: true)); // Fetch videos again after deletion
    }
  }

  Future<void> _onAddVideo(AddVideo event, Emitter<VideosState> emit) async {
    _videosLoaded = false;
    emit(VideosLoading());

    try {
      // Insert video to the database
      await DatabaseHelper().insertVideo(event.video);

      // Fetch videos again after adding a new video
      add(FetchVideos(forceRefresh: true));
    } catch (e) {
      emit(VideosError('Failed to add video: $e'));
    }
  }
}
