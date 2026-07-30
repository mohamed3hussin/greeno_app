import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:greeno_app/core/assets_date/iconBroken.dart';
import 'package:greeno_app/core/constants/primary_button.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/address_helper.dart';
import '../../domain/entities/address_entity.dart';

class MapPickerPage extends StatefulWidget {
  const MapPickerPage({super.key});

  @override
  State<MapPickerPage> createState() => _MapPickerPageState();
}

class _MapPickerPageState extends State<MapPickerPage> {

  Future<void> _selectLocation(LatLng point) async {

    final address = await AddressHelper.fromCoordinates(
      latitude: point.latitude,
      longitude: point.longitude,
    );

    Navigator.pop(context, address);
  }

  LatLng? selectedLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: const Text('Choose Location'),
        centerTitle: true,
      ) ,
      body: Stack(
        children: [
          FlutterMap(
              options: MapOptions(
                initialCenter: LatLng(30.0444, 31.2357),
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
                  markers: selectedLocation == null
                      ? []
                      : [
                    Marker(
                      point: selectedLocation!,
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
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.h),
              child: PrimaryButton(
                  text: 'Confirm Location',
                  onPressed: (){
                    _selectLocation(selectedLocation!);
                  },
              ),
            ),
          ),
        ],
      ),

    );
  }
}
