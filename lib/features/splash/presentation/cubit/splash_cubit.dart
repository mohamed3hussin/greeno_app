import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greeno_app/features/splash/domain/usecases/check_email_verification_use_case.dart';
import 'package:greeno_app/features/splash/presentation/cubit/splash_state.dart';

import '../../domain/usecases/get_current_user_use_case.dart';

class SplashCubit extends Cubit<SplashState> {
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final CheckEmailVerificationSplashUseCase checkVerificationSplashUseCase;

  SplashCubit({
    required this.getCurrentUserUseCase,
    required this.checkVerificationSplashUseCase,
  }) : super(SplashInitial());

  Future<void> checkAuthStatus() async{
    emit(SplashLoading());
    final userResult = await getCurrentUserUseCase();
    userResult.fold(
          (failure){
            emit(SplashError(failure.message));
          },
          (user) async{
            if(user == null){
              emit(SplashUnauthenticated());
              return;
            }
            final verificationResult = await checkVerificationSplashUseCase();

            verificationResult.fold(
                (failure){
                  emit(SplashError(failure.message));
                },
                (isVerified){
                  if (isVerified) {
                    emit(SplashAuthenticated(user));
                    print(user.email);
                  } else {
                    emit(SplashEmailNotVerified(user));
                  }
                }
            );

          }
    );
  }
}