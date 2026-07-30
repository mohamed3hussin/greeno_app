import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:greeno_app/features/auth/data/models/address_model.dart';
import 'package:greeno_app/features/auth/domain/entities/address_entity.dart';
import 'package:greeno_app/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    super.uid,
    required super.name,
    required super.email,
    required super.phone,
    required super.address,
    required super.createdAt,
    super.profileImage,
  });
  factory UserModel.fromEntity(UserEntity entity){
    return UserModel(
        uid: entity.uid,
        name: entity.name,
        email: entity.email,
        phone: entity.phone,
        address: entity.address,
        createdAt:entity.createdAt,
        profileImage: entity.profileImage,
    );
  }
  factory UserModel.fromJson(Map<String, dynamic> json){
    return UserModel(
      uid: json['uid'] as String?,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      address: AddressModel.fromJson(json['address'] as Map<String, dynamic>),
      createdAt: (json['createdAt'] as Timestamp).toDate(),
      profileImage: json['profileImage'] as String?,
    );
  }
  Map<String, dynamic> toJson(){
    return {
      'uid':uid,
      'name':name,
      'email':email,
      'phone':phone,
      'address':AddressModel.fromEntity(address).toJson(),
      'createdAt':Timestamp.fromDate(createdAt),
      'profileImage':profileImage,
    };
  }

  UserModel copyWith({
    String? uid,
    String? name,
    String? email,
    String? phone,
    AddressEntity? address,
    DateTime? createdAt,
    String? profileImage,
}){
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      createdAt: createdAt ?? this.createdAt,
      profileImage: profileImage ?? this.profileImage,
    );
  }
}
