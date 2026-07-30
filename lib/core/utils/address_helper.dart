import 'package:geocoding/geocoding.dart';

import '../../features/auth/domain/entities/address_entity.dart';

abstract class AddressHelper {
  static Future<AddressEntity> fromCoordinates({
    required double latitude,
    required double longitude,
  }) async {
    final placemarks = await placemarkFromCoordinates(
      latitude,
      longitude,
    );

    final place = placemarks.first;

    return AddressEntity(
      latitude: latitude,
      longitude: longitude,
      fullAddress: place.street ?? '',
      city: place.locality ?? '',
      governorate: place.administrativeArea ?? '',
      country: place.country ?? '',
    );
  }
}