import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibm_flutter_final_project/core/theming/colors.dart';
import 'package:ibm_flutter_final_project/core/theming/styles.dart';
import 'package:ibm_flutter_final_project/features/adminControls/ui/widgets/custem_reservation_item.dart';
import 'package:ibm_flutter_final_project/features/adminControls/ui/widgets/display_info.dart';

class BookedDetailsScreen extends StatelessWidget {
  const BookedDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsManager.mainWhite,
        title: Text(
          "Booked Details",
          style: TextStyles.font18blackbold,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            DisplayInfo(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ReservationButton(
                      text: 'Approve',
                    )),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    height: 48.h,
                    width: 385.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: ColorsManager.mainWhite,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black87.withOpacity(0.1),
                            blurRadius: 10,
                            offset: Offset(5, 5),
                            spreadRadius: 3,
                          )
                        ]),
                    child: Center(
                      child: Text(
                        "Reject",
                        style: TextStyles.font14blackbold,
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
