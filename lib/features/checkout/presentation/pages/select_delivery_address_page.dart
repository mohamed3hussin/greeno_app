import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:greeno_app/features/auth/domain/entities/address_entity.dart';
import 'package:greeno_app/features/home/presentation/widgets/home_icon_button.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/constants/primary_button.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/address_helper.dart';

class SelectDeliveryAddressPage extends StatefulWidget {
  const SelectDeliveryAddressPage({
    super.key,
    required this.currentAddress,
  });
  final AddressEntity currentAddress;

  @override
  State<SelectDeliveryAddressPage> createState() => _SelectDeliveryAddressPageState();
}

class _SelectDeliveryAddressPageState extends State<SelectDeliveryAddressPage> {
  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enable location service'),
        ),
      );
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Location permission denied'),
        ),
      );
      return;
    }

    final position = await Geolocator.getCurrentPosition();

    final address = await AddressHelper.fromCoordinates(
      latitude: position.latitude,
      longitude: position.longitude,
    );

    if (!mounted) return;

    setState(() {
      selectedAddress = address;

      selectedLocation = LatLng(
        position.latitude,
        position.longitude,
      );
    });
  }
  Future<void> _selectLocation(LatLng point) async {

    final address = await AddressHelper.fromCoordinates(
      latitude: point.latitude,
      longitude: point.longitude,
    );

    Navigator.pop(context, address);
  }

  late AddressEntity selectedAddress;
  late LatLng selectedLocation;

  @override
  void initState() {
    super.initState();

    selectedAddress = widget.currentAddress;
    selectedLocation = LatLng(selectedAddress.latitude,selectedAddress.longitude);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Delivery Address'),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: HomeIconButton(
              icon: Icons.location_searching_sharp,
              onPressed: () async {
                await _getCurrentLocation();
              },
              color: AppColors.primary,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              initialCenter: selectedLocation,
              initialZoom: 14,
              onTap: (tapPosition, point) {
                setState(() {
                  selectedLocation = point;
                });
              },
            ),
            children: [
              TileLayer(
                urlTemplate:
                "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                userAgentPackageName: "com.greeno.app",
              ),
              MarkerLayer(
                markers:
                     [
                  Marker(
                    point: selectedLocation,
                    width: 50,
                    height: 50,
                    child: const Icon(
                      Icons.location_on_sharp,
                      size: 45,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ],
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child:Padding(
              padding: EdgeInsets.all(20.w),
              child: PrimaryButton(
                text: 'Confirm Address',
                onPressed: () async {
                  await _selectLocation(selectedLocation);
                },
              ),
            ),
          ),

        ],
      ),
    );
  }
}
