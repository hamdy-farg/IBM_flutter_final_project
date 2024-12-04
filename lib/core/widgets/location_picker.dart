import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibm_flutter_final_project/core/di/dependancy_injection.dart';
import 'package:ibm_flutter_final_project/core/helpers/spacing.dart';
import 'package:ibm_flutter_final_project/core/theming/colors.dart';
import 'package:ibm_flutter_final_project/core/theming/styles.dart';
import 'package:ibm_flutter_final_project/core/widgets/open_map.dart';
import 'package:ibm_flutter_final_project/features/add_new_workspace/logic/workSpaceCubit/work_space_cubit.dart';
import 'package:latlong2/latlong.dart';

class LocationPickerWidget extends StatefulWidget {
  final void Function(LatLng) onLocationPicked;
  Map<String, double>? locationLatLong;
  bool? isStatic;
  LocationPickerWidget({
    this.isStatic,
    this.locationLatLong,
    required this.onLocationPicked,
  });

  @override
  State<LocationPickerWidget> createState() => _LocationPickerWidgetState();
}

class _LocationPickerWidgetState extends State<LocationPickerWidget> {
  LatLng? _pickedLocation;
  final cubit = getIt<WorkSpaceCubit>();
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
                      style: TextStyles
                          .font22blackMeduim, // Text style for the heading
                    ),
                  ),
                )
              : SizedBox(),
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
                                          widget.locationLatLong?["long"] ??
                                              1) ==
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
                                                widget.locationLatLong?[
                                                        "lat"] ??
                                                    1,
                                                widget.locationLatLong?[
                                                        "long"] ??
                                                    1) ==
                                            const LatLng(1, 1)
                                        ? _pickedLocation!
                                        : LatLng(
                                            widget.locationLatLong?["lat"] ?? 1,
                                            widget.locationLatLong?["long"] ??
                                                1),
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
                                        getIt<WorkSpaceCubit>()
                                            .locationChange(null);
                                        _pickedLocation = null;
                                        widget.locationLatLong = null;
                                      });
                                    },
                                  ),
                                )
                              : SizedBox(),
                        ],
                      ),
              ))
        ],
      ),
    );
  }
}
