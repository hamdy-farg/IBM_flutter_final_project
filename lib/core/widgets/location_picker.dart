import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
 import 'package:ibm_flutter_final_project/core/helpers/spacing.dart';
import 'package:ibm_flutter_final_project/core/theming/colors.dart';
import 'package:ibm_flutter_final_project/core/theming/styles.dart';
  import 'package:latlong2/latlong.dart';
 
class LocationPickerWidget extends StatefulWidget {
  final LatLng? initialLocation;
  final void Function(LatLng) onLocationPicked;

  const LocationPickerWidget({
    super.key,
    this.initialLocation,
    required this.onLocationPicked,
  });

  @override
  State<LocationPickerWidget> createState() => _LocationPickerWidgetState();
}

class _LocationPickerWidgetState extends State<LocationPickerWidget> {
  LatLng? _pickedLocation;

  // Method to open the map picker screen when the user wants to pick a location
  Future<void> _openLocationPicker() async {
    final LatLng? pickedLocation = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LocationPickerScreen(
          initialLocation: _pickedLocation ?? const LatLng(30.06263, 31.24967), // Default fallback location (Cairo)
        ),
      ),
    );

    if (pickedLocation != null) {
      setState(() {
        _pickedLocation = pickedLocation;
      });

      widget.onLocationPicked(pickedLocation); // Trigger the callback
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          Center(
            child: Text(
              "Pick a Location",
              style: TextStyles.font22blackMeduim, // Text style for the heading
            ),
          ),
          verticalSpace(12.h), // Spacer between widgets
          GestureDetector(
            onTap: _openLocationPicker, // Open the map picker when tapped
            child: Container(
              width: 317.w,
              height: 170.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: ColorsManager.lightGrey),
                image: _pickedLocation != null
                    ? const DecorationImage(
                        image: AssetImage("assets/images/splash2.png"),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: _pickedLocation == null
                  ? const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.map,
                            color: ColorsManager.mainBlue,
                            size: 50,
                          ),
                          Text(
                            "Pick a location",
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    )
                  : Stack(
                      children: [
                        FlutterMap(
                          options: MapOptions(
                            initialCenter: _pickedLocation!,
                            initialZoom: 20,
                          ),
                          children: [
                            TileLayer(
                              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                              userAgentPackageName: 'com.example.ibm_flutter_final_project',
                            ),
                            MarkerLayer(
                              markers: [
                                Marker(
                                  point: _pickedLocation!,
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
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

// LocationPickerScreen to let user select location from the map
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
    _currentLocation = widget.initialLocation;
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
              // Implement fetching current location if needed
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
                    _currentLocation = point;
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
                // Call the callback with the current location and pop back
                Navigator.pop(context, _currentLocation);
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: ColorsManager.mainBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  "Confirm Location",
                  style: TextStyles.font15WhiteRegular,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
