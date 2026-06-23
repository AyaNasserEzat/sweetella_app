import 'package:dartz/dartz.dart';
import 'package:sweetella/core/error/failure.dart';
import 'package:sweetella/feature/auth/data/models/user_model.dart';
import 'package:sweetella/feature/profile/data/data_source/profile_remote_data_source.dart';
import 'package:sweetella/feature/profile/data/repos/profile_repo.dart';

class ProfileRepoImp extends ProfileRepo {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepoImp(this.remoteDataSource);

  @override
  Future<Either<Failure, UserModel>> getProfile() async {
    try {
      final userModel = await remoteDataSource.getProfile();
      return right(userModel);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
