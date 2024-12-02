import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibm_flutter_final_project/core/helpers/spacing.dart';
import 'package:ibm_flutter_final_project/core/theming/colors.dart';
import 'package:ibm_flutter_final_project/core/theming/styles.dart';
import 'package:ibm_flutter_final_project/features/adminControls/ui/widgets/reservation_items.dart';
import 'package:ibm_flutter_final_project/features/adminControls/ui/widgets/search_bar.dart';
import 'package:ibm_flutter_final_project/features/authentication/ui/widgets/custem_button_authentication.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          horizantalSpace(25),
          CustemButtonAuthentication(
            text: 'Explore more',
            width: 320.w,
            height: 48.h,
          ),
        ],
      ),
      appBar: AppBar(
        backgroundColor: ColorsManager.mainWhite,
        title: Text(
          "My Booking",
          style: TextStyles.font18blackbold,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SearchBarTop(), // Non-scrollable header
          Expanded(
            child: ReservationItems(), // Scrollable content
          ),
          verticalSpace(50)
        ],
      ),
    );
  }
}
