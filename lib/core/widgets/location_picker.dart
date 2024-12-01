import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibm_flutter_final_project/core/helpers/spacing.dart';
import 'package:ibm_flutter_final_project/core/theming/colors.dart';
import 'package:ibm_flutter_final_project/core/theming/styles.dart';
import 'package:ibm_flutter_final_project/core/widgets/open_map.dart';
import 'package:latlong2/latlong.dart';

class LocationPickerWidget extends StatefulWidget {
  final void Function(LatLng) onLocationPicked;

  const LocationPickerWidget({
    super.key,
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
        builder: (context) => MapScreen(),
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
          GestureDetector(
            onTap: _openLocationPicker,
            child: Center(
              child: Text(
                "Pick a Location",
                style:
                    TextStyles.font22blackMeduim, // Text style for the heading
              ),
            ),
          ),
          verticalSpace(12.h),
          // Spacer between widgets
       
             GestureDetector(
              onTap: _openLocationPicker, // Open the map picker when tapped
              child: Container(
               
                height: 170.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: ColorsManager.semiWhite),
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
                                urlTemplate:
                                    'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                userAgentPackageName:
                                    'com.example.ibm_flutter_final_project',
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
                          // Add IconButton at the top-right corner
                          Positioned(
                            top: 10,
                            right: 10,
                            child: IconButton(
                              icon: const Icon(
                                Icons.close,
                                color: ColorsManager.mainBlue,
                                size: 30,
                              ),
                              onPressed: () {
                                setState(() {
                                  _pickedLocation =
                                      null; // Clear selected location
                                });
                              },
                            ),
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
