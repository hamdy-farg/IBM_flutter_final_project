import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
class LocationScreen extends StatelessWidget {
  // Coordinates for Google Maps (adjust latitude and longitude as needed)
  final double latitude = 47.6062;
  final double longitude = -122.3321;

  // Function to launch Google Maps with specified coordinates
  void _openMap() async {
    final url = 'https://maps.app.goo.gl/w4CqtYPpUT2Hf5nN6';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not open the map.';
    }
  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Center(
        child: GestureDetector(
          onTap: _openMap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             Container(
              height: 280,
              width: 400,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/images/googlemaps.jpg"),
                fit: BoxFit.cover,
                )
              ),
            ),
             
            ],
          ),
        ),
      ),
    );
  }
}