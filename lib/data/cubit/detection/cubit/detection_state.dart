part of 'detection_cubit.dart';

@immutable
sealed class DetectionState {}

final class DetectionInitial extends DetectionState {}

final class DetectionLoading extends DetectionState {}

final class DetectionSuccess extends DetectionState {
  final dynamic response;

  DetectionSuccess(this.response);
}

final class DetectionError extends DetectionState {
  final String message;

  DetectionError(this.message);
}
