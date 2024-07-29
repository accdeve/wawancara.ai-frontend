import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'pertanyaan_state.dart';

class PertanyaanCubit extends Cubit<PertanyaanState> {
  PertanyaanCubit() : super(const PertanyaanInitial());

  void updatePertanyaanAndDurasi(String pertanyaan, int durasi, String type) {
    emit(PertanyaanLoaded(pertanyaan: pertanyaan, durasi: durasi, type: type));
  }
}
