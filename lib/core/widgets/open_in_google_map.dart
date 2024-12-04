import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class GoogleMapsButton extends StatelessWidget {
  final String url; // URL to open in Google Maps
  final String buttonText; // Button label text (optional)

  const GoogleMapsButton({
    Key? key,
    required this.url,
    this.buttonText = "Open in Google Maps",
  }) : super(key: key);
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
    return ElevatedButton(
      onPressed: () => _openInGoogleChrome(url),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        buttonText,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
