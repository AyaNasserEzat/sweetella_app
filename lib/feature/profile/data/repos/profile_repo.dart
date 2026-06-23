import 'package:dartz/dartz.dart';
import 'package:sweetella/core/error/failure.dart';
import 'package:sweetella/feature/auth/data/models/user_model.dart';

abstract class ProfileRepo {
  Future<Either<Failure, UserModel>> getProfile();
}
