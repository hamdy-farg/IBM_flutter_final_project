import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibm_flutter_final_project/core/theming/colors.dart';
import 'package:ibm_flutter_final_project/core/theming/styles.dart';
import 'package:ibm_flutter_final_project/core/helpers/spacing.dart';

class LocationPickerWidget extends StatefulWidget {
  final LatLng? initialLocation;
  final void Function(LatLng) onLocationPicked;

  const LocationPickerWidget({
    Key? key,
    this.initialLocation,
    required this.onLocationPicked,
  }) : super(key: key);

  @override
  State<LocationPickerWidget> createState() => _LocationPickerWidgetState();
}

class _LocationPickerWidgetState extends State<LocationPickerWidget> {
  LatLng? _pickedLocation;

  Future<void> _openLocationPicker() async {
    final LatLng? pickedLocation = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LocationPickerScreen(
          initialLocation: _pickedLocation ?? LatLng(51.509364, -0.128928), // Default location
        ),
      ),
    );

    if (pickedLocation != null) {
      setState(() {
        _pickedLocation = pickedLocation;
      });
      widget.onLocationPicked(pickedLocation);
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
              style: TextStyles.font22blackMeduim,
            ),
          ),
          verticalSpace(12.h),
          GestureDetector(
            onTap: _openLocationPicker,
            child: Container(
              width: 317.w,
              height: 170.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: ColorsManager.lightGrey),
                image: _pickedLocation != null
                    ? DecorationImage(
                        image: AssetImage("assets/location_image.png"), // Placeholder image
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
                            initialZoom: 15, // Use a reasonable zoom level
                          ),
                          children: [
                            TileLayer(
                              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                              userAgentPackageName: 'com.example.app',
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
              // Implement current location fetching if needed
            },
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: FlutterMap(
              options: MapOptions(
                initialCenter: _currentLocation, // Correct property for setting the center
                initialZoom: 15, // Use a reasonable zoom level
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
                      child: Icon(
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
