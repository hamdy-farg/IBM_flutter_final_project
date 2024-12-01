import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibm_flutter_final_project/core/theming/colors.dart';
import 'package:ibm_flutter_final_project/core/theming/styles.dart';
import 'package:ibm_flutter_final_project/features/adminControls/ui/widgets/reservation_items.dart';
import 'package:ibm_flutter_final_project/features/adminControls/ui/widgets/search_bar.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsManager.mainWhite,
        title: Text("My Booking",style: TextStyles.font18blackbold,),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
          SearchBarTop(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            
            child: ReservationItems(),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              height: 48.h,
              width: 385.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: ColorsManager.mainblue2,
              ),
              child: Center(
                child: Text("Book New",style: TextStyles.font14WhiteBold,),
              ),
            ),
          )
          ],
        ),
      ),
    );
  }
}