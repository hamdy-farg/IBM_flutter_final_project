import 'package:flutter/material.dart';
import 'package:ibm_flutter_final_project/core/theming/styles.dart';
import 'package:ibm_flutter_final_project/features/home/ui/booking_photo.dart';
import 'package:ibm_flutter_final_project/features/home/ui/date_features.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 250,
              width: double.infinity,
              child: BookingPhoto()),
        
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Small Metting Room",style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.black,
                ),),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(Icons.timer,color: Colors.grey,),
                    Text("Today- ",style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),),
                    Text("12 AM - 11:95 PM",style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 150,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey,
                
                  ),
                  child: Center(
                    child: Text("20 Seats",style: TextStyles.font20whitebold,),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Paragraphs are the building blocks of papers. Many students define paragraphs in terms of length: a paragraph is a group of at least five sentences, a paragraph is half a page long, etc. In reality, though, the unity and coherence of ideas among sentences is what constitutes a paragraph.",style: TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                ),),
              ),
              SizedBox(
                height: 600,
                width: double.infinity,
                child: DateFeatures(),
              ),
             
          ],
        ),
      ),
    );
  }
}