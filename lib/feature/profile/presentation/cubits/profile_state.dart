import 'package:sweetella/feature/auth/data/models/user_model.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class GetProfileLoading extends ProfileState {}

class GetProfileSuccess extends ProfileState {
  final UserModel userModel;

  GetProfileSuccess(this.userModel);
}

class GetProfileFailure extends ProfileState {
  final String errorMessage;

  GetProfileFailure(this.errorMessage);
}
