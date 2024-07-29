part of 'videos_bloc.dart';

@immutable
abstract class VideosEvent {}

class FetchVideos extends VideosEvent {
  final bool forceRefresh;

  FetchVideos({this.forceRefresh = false});
}

class SelectVideo extends VideosEvent {
  final Video? video;
  final bool clearSelection;

  SelectVideo(this.video, {this.clearSelection = false});
}


class DeleteSelectedVideos extends VideosEvent {}

class AddVideo extends VideosEvent {
  final Video video;

  AddVideo(this.video);
}
