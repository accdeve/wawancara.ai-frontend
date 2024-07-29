part of 'pertanyaan_cubit.dart';

@immutable
sealed class PertanyaanState {
  final String pertanyaan;
  final int durasi;
  final String type;

  const PertanyaanState({required this.pertanyaan, required this.durasi, required this.type});
}

final class PertanyaanInitial extends PertanyaanState {
  const PertanyaanInitial() : super(pertanyaan: '', durasi: 0, type: "umum");
}

final class PertanyaanLoaded extends PertanyaanState {
  const PertanyaanLoaded({required super.pertanyaan, required super.durasi, required super.type});
}
