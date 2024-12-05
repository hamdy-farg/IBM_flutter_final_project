// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ibm_flutter_final_project/core/helpers/utils.dart';
import 'package:ibm_flutter_final_project/core/theming/styles.dart';

// Custom Widget to Fetch Location Name

// class LocationFetcher extends StatelessWidget {
//   final String mapUrl;

//   LocationFetcher({required this.mapUrl});

//   @override
//   Widget build(BuildContext context) {
//     // Extract coordinates from Google Maps URL
//     // final coordinates = extractCoordinates(mapUrl);

//     return FutureBuilder<String>(
//       future: getLocationName("coordinates"),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return CircularProgressIndicator();
//         } else if (snapshot.hasError) {
//           return Text("Error: ${snapshot.error}");
//         } else {
//           return Text(
//             snapshot.data ?? "Unknown Location",
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           );
//         }
//       },
//     );
//   }
// }
class getLocationText extends StatelessWidget {
  final String location;
  final TextStyle? textStyle;
  const getLocationText({
    Key? key,
    required this.location,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: getLocationName(extractLatLong(location ?? "") ?? {}),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            width: 10,
            height: 10,
            alignment: Alignment.center,
            child: SizedBox(
                height: 10,
                width: 10,
                child: CircularProgressIndicator(
                  color: Colors.white,
                )),
          );
        } else if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        } else {
          return Text(
            snapshot.data ?? "Unknown Location",
            style: textStyle ?? TextStyles.font13WhiteReagualer,
            overflow: TextOverflow.ellipsis,
          );
        }
      },
    );
  }
}

Future<String> getLocationName(Map<String, double> coordinates) async {
  if (coordinates.length != 2) {
    return "Invalid coordinates.";
  }

  final url =
      "https://nominatim.openstreetmap.org/reverse?format=json&lat=${coordinates["lat"]}&lon=${coordinates["long"]}&accept-language=en";
  try {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      return data['display_name']
              .toString()
              .split(",")
              .sublist(1, 3)
              .join(",")
              .toString() ??
          "Unknown Location";
    } else {
      return "Failed to fetch location.";
    }
  } catch (e) {
    return "Error: $e";
  }
}
