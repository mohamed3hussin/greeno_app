import 'package:greeno_app/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> register({
    required String email,
    required String password,
    required UserModel user,
});

  Future<UserModel> login({
    required String email,
    required String password,
  });

  Future<void> forgetPassword({
    required String email,
  });

  Future<void> sendEmailVerification();

  Future<bool> checkEmailVerification();

  Future<void> logout();
}