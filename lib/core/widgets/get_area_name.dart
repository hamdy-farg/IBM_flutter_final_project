


import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

  
// Custom Widget to Fetch Location Name
class LocationFetcher extends StatelessWidget {
  final String mapUrl;

  LocationFetcher({required this.mapUrl});

  @override
  Widget build(BuildContext context) {
    // Extract coordinates from Google Maps URL
    final coordinates = extractCoordinates(mapUrl);

    return FutureBuilder<String>(
      future: getLocationName(coordinates),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        } else {
          return Text(
            snapshot.data ?? "Unknown Location",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          );
        }
      },
    );
  }
}

 String extractCoordinates(String url) {
   final regex = RegExp(r"@([-+]?\d*\.\d+),([-+]?\d*\.\d+)");
  final match = regex.firstMatch(url);

  if (match != null) {
    final lat = match.group(1);
    final lon = match.group(2);
    if (lat != null && lon != null) {
      return "$lat,$lon"; 
    }
  }
  return "";
}

 Future<String> getLocationName(String coordinates) async {
  final latLon = coordinates.split(',');

   if (latLon.length != 2) {
    return "Invalid coordinates.";
  }

  final url =
      "https://nominatim.openstreetmap.org/reverse?format=json&lat=${latLon[0]}&lon=${latLon[1]}";

  try {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['display_name'] ?? "Unknown Location";
    } else {
      return "Failed to fetch location.";
    }
  } catch (e) {
    return "Error: $e";
  }
}
