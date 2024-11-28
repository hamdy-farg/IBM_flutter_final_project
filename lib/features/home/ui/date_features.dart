import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ibm_flutter_final_project/core/theming/styles.dart';
import 'package:ibm_flutter_final_project/features/home/ui/calender.dart';
import 'package:ibm_flutter_final_project/features/home/ui/time_hours.dart';


class DateFeatures extends StatelessWidget {
  const DateFeatures({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
             height: 150,
             width: 500,
             child: DatePickerScreen(),
            ),

            SizedBox(
             height: 300,
             width: double.infinity,
             child: TimeSelectionScreen(),
            ),

            
            Center(
                child: Container(
                  height: 58.h,
                  width: 271.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.blue[700],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(child: Text("Review Booking - EGP 2000",style: TextStyles.font20whitebold,)),
                  ),
                ),
              )
           
          ],
        ),
      ),
    );
  }
}
