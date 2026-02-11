import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../controllers/delivery_address_controller.dart';

class MapPickerScreen extends StatefulWidget {
  const MapPickerScreen({super.key});

  @override
  State<MapPickerScreen> createState() => _MapPickerScreenState();
}

class _MapPickerScreenState extends State<MapPickerScreen> {

  final DeliveryAddressController controller = Get.find<DeliveryAddressController>();
  GoogleMapController? _mapController;

  @override
  void initState() {
    super.initState();
  }

  // Automatically get device location
  Future<void> _setCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }
    if (permission == LocationPermission.deniedForever) return;

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    LatLng current = LatLng(position.latitude, position.longitude);
    controller.updateLocation(current);
    _mapController?.animateCamera(CameraUpdate.newLatLng(current));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('select location'.tr)),
        body: Column(
          children: [
            Expanded(
              child: Obx(() {
                final loc = controller.selectedLocation.value;
                return GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: loc,
                    zoom: 16,
                  ),
                  onMapCreated: (mapController) {
                    _mapController = mapController;
                    _setCurrentLocation();
                  },
                  onTap: controller.updateLocation,
                  markers: {
                    Marker(
                      markerId: const MarkerId('picked'),
                      position: loc,
                      draggable: true,
                      onDragEnd: controller.updateLocation,
                    ),
                  },
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                );
              }),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  onPressed: () {
                    Get.back(result: controller.address.value);
                  },
                  child: Text('confirm location'.tr, style: const TextStyle(fontSize: 16)),
                ),
              ),
            ),
        ],
      )
    );
  }


}