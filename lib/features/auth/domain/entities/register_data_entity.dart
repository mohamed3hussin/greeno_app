import 'package:equatable/equatable.dart';

class RegisterDataEntity extends Equatable {
  final String name;
  final String email;
  final String phone;
  final String password;

  const RegisterDataEntity({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
  });

  @override
  List<Object?> get props => [
    name,
    email,
    phone,
    password,
  ];
}