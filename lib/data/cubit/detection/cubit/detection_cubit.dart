import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wawancara_ai/api/api_provider.dart';
import 'package:wawancara_ai/db/database_helper.dart';
import 'package:wawancara_ai/utils/constants.dart';

part 'detection_state.dart';

class DetectionCubit extends Cubit<DetectionState> {
  DetectionCubit() : super(DetectionInitial());
  final ApiProvider _provider = ApiProvider();
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<void> uploadFiles(String endpoint, String videoId, List<File> files) async {
    emit(DetectionLoading());
    try {
      var response = await _provider.postMultipart("$BASE_URL/$endpoint?key=$KEY", files: files);
      if (response['status'] == "success") {
        await _databaseHelper.updateVideoDetectionValues(
          videoId,
          response['data']['smile_count'],
          response['data']['gaze_count'],
          response['data']['hand_count'],
          response['data']['head_count'],
          1
        );
        emit(DetectionSuccess(response));
      } else {
        emit(DetectionError('Failed to upload files: ${response['message']}'));
      }
    } catch (e) {
      emit(DetectionError('Failed to upload files: $e'));
    }
  }
}
