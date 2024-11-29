import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:ibm_flutter_final_project/core/di/dependancy_injection.dart';
import 'package:ibm_flutter_final_project/core/theming/colors.dart';
import 'package:ibm_flutter_final_project/core/theming/styles.dart';
import 'package:ibm_flutter_final_project/features/add_new_workspace/logic/AddNewWorkSpaceCubit/add_new_work_space_cubit.dart';
import 'package:latlong2/latlong.dart';

class LocationPickerScreen extends StatefulWidget {
  final LatLng initialLocation;

  const LocationPickerScreen({super.key, required this.initialLocation});

  @override
  State<LocationPickerScreen> createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  late LatLng _currentLocation;

  @override
  void initState() {
    super.initState();
    _currentLocation = widget.initialLocation; // Set the initial location
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pick a Location"),
        actions: [
          IconButton(
            icon: const Icon(Icons.my_location),
            onPressed: () {
              // Implement current location fetching if needed
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: FlutterMap(
              options: MapOptions(
                initialCenter: _currentLocation,
                initialZoom: 15,
                onTap: (tapPosition, point) {
                  setState(() {
                    _currentLocation = point; // Update current location on tap
                  });
                },
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.app',
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: _currentLocation,
                      child: const Icon(
                        Icons.location_pin,
                        size: 40,
                        color: ColorsManager.mainBlue,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: () {
                // When confirmed, save location as Google Maps URL using cubit and pop back
                final cubit = getIt<AddNewWorkSpaceCubit>();
                final googleMapUrl = _generateGoogleMapsUrl(_currentLocation);

                // Save the Google Maps URL in cubit
                print(googleMapUrl);
                cubit.locationChange(googleMapUrl);

                // Pop back to the previous screen with the selected location
                Navigator.pop(context, _currentLocation);
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: ColorsManager.mainBlue, // Button background color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Button corner radius
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  "Confirm Location",
                  style: TextStyles
                  .font15WhiteRegular, // Text style for the button
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Convert LatLng to Google Maps URL
  String _generateGoogleMapsUrl(LatLng location) {
    return 'https://www.google.com/maps?q=${location.latitude},${location.longitude}';
  }
}
