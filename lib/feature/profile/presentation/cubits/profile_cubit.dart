import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweetella/feature/profile/data/repos/profile_repo.dart';
import 'package:sweetella/feature/profile/presentation/cubits/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo repo;
  ProfileCubit(this.repo) : super(ProfileInitial());
  getProfile() async {
    emit(GetProfileLoading());
    final result = await repo.getProfile();
    result.fold(
      (failure) => emit(GetProfileFailure(failure.message)),
      (userModel) => emit(GetProfileSuccess(userModel)),
    );
  }
}
