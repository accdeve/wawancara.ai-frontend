import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wawancara_ai/db/database_helper.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final DatabaseHelper _databaseHelper;

  ProfileCubit(this._databaseHelper) : super(ProfileInitial()) {
    fetchProfileData();
  }

  void fetchProfileData() async {
    try {
      emit(ProfileLoading());
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? name = prefs.getString('name');
      String? job = prefs.getString('job');
      final userData = {'name': name ?? 'Anu', 'job': job ?? 'Teknik Sipil'};

      // Fetch counts and detection sums
      final umumCount = await _databaseHelper.countUmumVideos();
      final customCount = await _databaseHelper.countCustomVideos();
      final detectionValues = await _databaseHelper.sumDetectionValues();

      final data = {
        'userData': userData,
        'umumCount': umumCount,
        'customCount': customCount,
        'smileDetectionSum': detectionValues['smileDetectionSum'],
        'gazeDetectionSum': detectionValues['gazeDetectionSum'],
        'handDetectionSum': detectionValues['handDetectionSum'],
        'headDetectionSum': detectionValues['headDetectionSum'],
      };

      emit(ProfileSuccess(data));
    } catch (e) {
      emit(ProfileFailure());
    }
  }
}
