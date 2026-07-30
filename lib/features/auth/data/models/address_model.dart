import 'package:greeno_app/features/auth/domain/entities/address_entity.dart';

class AddressModel extends AddressEntity {
  const AddressModel({
    required super.latitude,
    required super.longitude,
    required super.fullAddress,
    required super.city,
    required super.governorate,
    required super.country,
  });
  factory AddressModel.fromJson(Map<String,dynamic> json){
    return AddressModel(
        latitude: (json['latitude'] as num).toDouble(),
        longitude: (json['longitude'] as num).toDouble(),
        fullAddress: json['fullAddress'] ??'',
        city: json['city'] ??'',
        governorate: json['governorate'] ??'',
        country: json['country'] ?? '');
  }
  Map<String,dynamic> toJson(){
    return{
      'latitude':latitude,
      'longitude':longitude,
      'fullAddress':fullAddress,
      'city':city,
      'governorate':governorate,
      'country':country,
    };
  }
  factory AddressModel.fromEntity(AddressEntity entity){
    return AddressModel(
        latitude: entity.latitude,
        longitude: entity.longitude,
        fullAddress: entity.fullAddress,
        city: entity.city,
        governorate: entity.governorate,
        country: entity.country,);
  }

}