import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/auth_repo_impl.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepoImpl authRepo;

  // Controllers
  final TextEditingController signInEmailController = TextEditingController();
  final TextEditingController signInPasswordController =
      TextEditingController();

  final TextEditingController signUEmailController = TextEditingController();
  final TextEditingController signUPasswordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  final TextEditingController forgetPassordEmailController =
      TextEditingController();

  AuthCubit(this.authRepo) : super(AuthInitial());

  Future<void> signIn() async {
    emit(SignInLoading());
    final result = await authRepo.signIn(
      email: signInEmailController.text.trim(),
      password: signInPasswordController.text.trim(),
    );
    result.fold(
      (failure) => emit(SignInError(failure.message)),
      (userCredential) => emit(SignInSuccess()),
    );
  }

  Future<void> signUp() async {
    emit(SignUpLoading());
    final result = await authRepo.signUp(
      email: signUPasswordController.text.trim(),
      password: signInPasswordController.text.trim(),
      name: signInEmailController.text.trim(),
    );
    result.fold(
      (failure) => emit(SignUpError(failure.message)),
      (userCredential) => emit(SignUpSuccess()),
    );
  }

  Future<void> resetPassword() async {
    emit(ForgetPasswordLoading());
    final result = await authRepo.resetPassword(
      forgetPassordEmailController.text.trim(),
    );
    result.fold(
      (failure) => emit(ForgetPasswordError(failure.message)),
      (message) => emit(ForgetPasswordSuccess()),
    );
  }

  Future<void> signOut() async {
    await authRepo.signOut();
    emit(AuthUnauthenticated());
  }

  @override
  Future<void> close() {
    signInEmailController.dispose();
    signInPasswordController.dispose();
    signUEmailController.dispose();
    signUPasswordController.dispose();
    forgetPassordEmailController.dispose();
    nameController.dispose();
    return super.close();
  }
}
