import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibm_flutter_final_project/core/theming/colors.dart';
import 'package:ibm_flutter_final_project/core/widgets/open_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart'; // Import url_launcher

class LocationPickerWidget extends StatefulWidget {
  final void Function(LatLng) onLocationPicked;
  Map<String, double>? locationLatLong;
  bool? isStatic;
  LocationPickerWidget({
    super.key,
    this.locationLatLong,
    required this.onLocationPicked,
    this.isStatic,
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
        builder: (context) => const MapScreen(),
      ),
    );

    if (pickedLocation != null) {
      setState(() {
        _pickedLocation = pickedLocation;
      });

      widget.onLocationPicked(pickedLocation); // Trigger the callback
    }
  }

  // Method to open the location in Google Chrome
  Future<void> _openInGoogleChrome(String location) async {
    final Uri url = Uri(
        scheme:
            'https');
    try {
      // ignore: deprecated_member_use
      if (!await launchUrl(

        url,
        mode: LaunchMode.externalApplication,
      )) {
        throw Exception('Could not launch $url');
      } else {
        log('Could not open the map in Google Chrome.');
        throw 'Could not open the map in Google Chrome.';
      }
    } catch (e) {
      log('Error opening Google Chrome: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    log("location is  ${widget.locationLatLong}");
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          widget.isStatic == null
              ? GestureDetector(
                  onTap: _openLocationPicker,
                  child: Center(
                    child: Text(
                      "Pick a Location",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600), // Custom style
                    ),
                  ),
                )
              : SizedBox(),
          SizedBox(height: 12.h), // Spacer between widgets

          GestureDetector(
            onTap: _openLocationPicker, // Open the map picker when tapped
            child: Container(
              height: 170.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: ColorsManager.semiWhite),
              ),
              child: _pickedLocation == null && widget.locationLatLong == null
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
                            initialCenter: LatLng(
                                        widget.locationLatLong?["lat"] ?? 1,
                                        widget.locationLatLong?["long"] ?? 1) ==
                                    const LatLng(1, 1)
                                ? _pickedLocation!
                                : LatLng(widget.locationLatLong?["lat"] ?? 1,
                                    widget.locationLatLong?["long"] ?? 1),
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
                                  point: LatLng(
                                              widget.locationLatLong?["lat"] ??
                                                  1,
                                              widget.locationLatLong?["long"] ??
                                                  1) ==
                                          const LatLng(1, 1)
                                      ? _pickedLocation!
                                      : LatLng(
                                          widget.locationLatLong?["lat"] ?? 1,
                                          widget.locationLatLong?["long"] ?? 1),
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
                        widget.isStatic == null
                            ? Positioned(
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
                                      _pickedLocation = null;
                                      widget.locationLatLong = null;
                                    });
                                  },
                                ),
                              )
                            : SizedBox(),
                      ],
                    ),
            ),
          ),
          // Add Text to open the location in Google Chrome
          if (_pickedLocation != null)
            GestureDetector(
              onTap: () => _openInGoogleChrome('://www.google.com/maps?q=31,31}'),
              child: Text(
                "Open in Google Chrome",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: ColorsManager.mainBlue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
        ],
      ),
    );
  }
}


 