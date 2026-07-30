import 'package:equatable/equatable.dart';

class AddressEntity extends Equatable
{
  final double latitude;
  final double longitude;
  final String fullAddress;
  final String city;
  final String governorate;
  final String country;

  const AddressEntity(
      {
        required this.latitude,
        required this.longitude,
        required this.fullAddress,
        required this.city,
        required this.governorate,
        required this.country,
      });

  @override
  // TODO: implement props
  List<Object?> get props =>
      [
        latitude,
        longitude,
        fullAddress,
        city,
        governorate,
        country,
      ];

}