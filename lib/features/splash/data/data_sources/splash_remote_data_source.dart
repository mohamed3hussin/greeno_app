import 'package:greeno_app/features/auth/data/models/user_model.dart';

abstract class SplashRemoteDataSource {
  Future<UserModel?> getCurrentUser();
  Future<bool> isEmailVerified();
}