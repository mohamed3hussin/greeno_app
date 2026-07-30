import 'package:equatable/equatable.dart';

import '../../../auth/domain/entities/user_entity.dart';

abstract class SplashState extends Equatable {
  const SplashState();
  @override
  List<Object?> get props => [];
}
class SplashInitial extends SplashState {}

class SplashLoading extends SplashState {}

class SplashUnauthenticated extends SplashState {}

class SplashAuthenticated extends SplashState {
  final UserEntity user;

  const SplashAuthenticated(this.user);

  @override
  List<Object?> get props => [user];
}

class SplashEmailNotVerified extends SplashState {
  final UserEntity user;

  const SplashEmailNotVerified(this.user);

  @override
  List<Object?> get props => [user];
}

class SplashError extends SplashState {
  final String message;

  const SplashError(this.message);

  @override
  List<Object?> get props => [message];
}