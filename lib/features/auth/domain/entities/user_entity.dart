import 'package:equatable/equatable.dart';

import 'package:greeno_app/features/auth/domain/entities/address_entity.dart';

class UserEntity extends Equatable {
  final String? uid;
  final String name;
  final String email;
  final String phone;
  final AddressEntity address;
  final DateTime createdAt;
  final String? profileImage;

  const UserEntity({
    this.uid,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.createdAt,
    this.profileImage,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    uid,
    name,
    email,
    phone,
    address,
    createdAt,
    profileImage,
  ];
}
