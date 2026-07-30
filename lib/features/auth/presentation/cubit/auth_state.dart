import 'package:equatable/equatable.dart';
import 'package:greeno_app/features/auth/domain/entities/user_entity.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  @override

  List<Object?> get props => [];
}
class AuthInitial extends AuthState{}

class AuthLoading extends AuthState{}

class AuthAuthenticated extends AuthState{
  final UserEntity user;
  const AuthAuthenticated({required this.user});
  @override
  // TODO: implement props
  List<Object?> get props => [user];
}

class RegisterSuccess extends AuthState {
  final UserEntity user;
  const RegisterSuccess(this.user);
  @override
  // TODO: implement props
  List<Object?> get props => [user];
}

class AuthError extends AuthState{
  final String message;
  const AuthError({required this.message});
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
class ForgotPasswordSuccess extends AuthState{}

class SendEmailVerificationSuccess extends AuthState{}

class EmailVerifiedSuccess extends AuthState {}

class AuthLoggedOut extends AuthState{}

class EmailNotVerified extends AuthState {}