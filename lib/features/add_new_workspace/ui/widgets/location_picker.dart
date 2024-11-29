import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibm_flutter_final_project/core/di/dependancy_injection.dart';
import 'package:ibm_flutter_final_project/core/helpers/spacing.dart';
import 'package:ibm_flutter_final_project/core/theming/colors.dart';
import 'package:ibm_flutter_final_project/core/theming/styles.dart';
import 'package:ibm_flutter_final_project/features/add_new_workspace/logic/AddNewWorkSpaceCubit/add_new_work_space_cubit.dart';
import 'package:ibm_flutter_final_project/features/add_new_workspace/logic/AddNewWorkSpaceCubit/add_new_work_space_cubit_state.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Main widget that allows user to pick a location and display it
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
    // Open the location picker screen and wait for the picked location
    final LatLng? pickedLocation = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LocationPickerScreen(
          initialLocation: _pickedLocation ?? const LatLng(30.06263, 31.24967), // Default fallback location (Cairo)
        ),
      ),
    );

    // If a location is picked, update the state and save it
    if (pickedLocation != null) {
      setState(() {
        _pickedLocation = pickedLocation;
      });

      // Convert the picked location to a Google Maps URL
      final googleMapUrl = _generateGoogleMapsUrl(pickedLocation);

      // Save the location using Cubit (passing the Google Maps URL)
      final cubit = getIt<AddNewWorkSpaceCubit>();
      cubit.locationChange(googleMapUrl); // Save the URL in cubit

      // Log the URL for debugging
      print(googleMapUrl);

      // Call the provided callback with the picked location
      widget.onLocationPicked(pickedLocation);
    }
  }

  // Convert LatLng to a Google Maps URL
  String _generateGoogleMapsUrl(LatLng location) {
    return 'https://www.google.com/maps?q=${location.latitude},${location.longitude}';
  }

  @override
  Widget build(BuildContext context) {
    final cubit = getIt<AddNewWorkSpaceCubit>(); // Getting the cubit instance
    return BlocProvider(
      create: (_) => cubit, // Providing cubit to widget tree
      child: BlocBuilder<AddNewWorkSpaceCubit, AddNewWorkSpaceState>(
        bloc: cubit,
        builder: (context, state) {
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
                                    urlTemplate:
                                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
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
        },
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
                  style: TextStyles.font15WhiteRegular, // Text style for the button
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
