part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileSuccess extends ProfileState {
  final Map<String, dynamic> data;

  ProfileSuccess(this.data);
}

final class ProfileFailure extends ProfileState {}
