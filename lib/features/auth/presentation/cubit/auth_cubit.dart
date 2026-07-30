import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greeno_app/features/auth/domain/entities/user_entity.dart';
import 'package:greeno_app/features/auth/domain/usecases/check_email_verification_usecase.dart';
import 'package:greeno_app/features/auth/domain/usecases/forgot_password_usecase.dart';
import 'package:greeno_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:greeno_app/features/auth/domain/usecases/logout_usecase.dart';
import 'package:greeno_app/features/auth/domain/usecases/register_usecase.dart';
import 'package:greeno_app/features/auth/domain/usecases/send_email_verification_usecase.dart';
import 'package:greeno_app/features/auth/presentation/cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final RegisterUseCase registerUseCase;
  final LoginUseCase loginUseCase;
  final ForgotPasswordUseCase forgotPasswordUseCase;
  final SendEmailVerificationUseCase sendEmailVerificationUseCase;
  final CheckEmailVerificationUseCase checkEmailVerificationUseCase;
  final LogoutUseCase logoutUseCase;

  AuthCubit({
    required this.registerUseCase,
    required this.loginUseCase,
    required this.forgotPasswordUseCase,
    required this.sendEmailVerificationUseCase,
    required this.checkEmailVerificationUseCase,
    required this.logoutUseCase,
  }): super(AuthInitial());

  Future<void> register({
    required String email,
    required String password,
    required UserEntity user,
})async{
    emit(AuthLoading());
    final result = await registerUseCase(
      email: email,
      password: password,
      user: user,
    );
    result.fold(
            (failure){
              emit(AuthError(message: failure.message));
            },
        (user){
              emit(RegisterSuccess(user));
        });
  }


  Future<void> login({
    required String email,
    required String password,
}) async {
    emit(AuthLoading());
    final result = await loginUseCase(
      email: email,
      password: password,
    );
    result.fold(
            (failure){
          emit(AuthError(message: failure.message));
        },
            (user){
          emit(AuthAuthenticated(user: user));
        });

  }

  Future<void> forgotPassword({
    required String email,
})async{
    emit(AuthLoading());

    final result = await forgotPasswordUseCase(
      email: email,
    );
    result.fold(
            (failure){
          emit(AuthError(message: failure.message));
        },
            (_){
          emit(ForgotPasswordSuccess());
        });
  }

  Future<void> sendEmailVerification()async{
    emit(AuthLoading());
    final result = await sendEmailVerificationUseCase();
    result.fold(
            (failure){
          emit(AuthError(message: failure.message));
        },
            (_){
          emit(SendEmailVerificationSuccess());
        });

  }

  Future<void> checkEmailVerification() async {
    emit(AuthLoading());

    final result = await checkEmailVerificationUseCase();

    result.fold(
          (failure) {
        emit(
          AuthError(
            message: failure.message,
          ),
        );
      },
          (isVerified) {
        if (isVerified) {
          emit(EmailVerifiedSuccess());
        } else {
          emit(EmailNotVerified());
        }
      },
    );
  }

  Future<void> logout()async{
    emit(AuthLoading());
    final result = await logoutUseCase();
    result.fold(
            (failure){
          emit(AuthError(message: failure.message));
        },
            (_){
          emit(AuthLoggedOut());
        });

  }
}