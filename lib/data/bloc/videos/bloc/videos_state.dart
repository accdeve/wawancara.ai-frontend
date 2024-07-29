part of 'videos_bloc.dart';

@immutable
sealed class VideosState {}

final class VideosInitial extends VideosState {}

final class VideosLoading extends VideosState {}

final class VideosLoaded extends VideosState {
  final List<Video> videos;
  final List<VideoPlayerController> controllers;
  final List<Video> selectedVideos;

  VideosLoaded(this.videos, this.controllers, {this.selectedVideos = const []});
}

final class VideosError extends VideosState {
  final String message;

  VideosError(this.message);
}
