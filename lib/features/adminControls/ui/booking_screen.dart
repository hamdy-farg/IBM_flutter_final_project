import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibm_flutter_final_project/core/di/dependancy_injection.dart';
import 'package:ibm_flutter_final_project/core/helpers/spacing.dart';
import 'package:ibm_flutter_final_project/features/adminControls/logic/bookingCubit/bookings_cubit.dart';
import 'package:ibm_flutter_final_project/features/adminControls/ui/widgets/reservation_items.dart';
import 'package:ibm_flutter_final_project/features/adminControls/ui/widgets/search_bar.dart';
import 'package:ibm_flutter_final_project/features/authentication/ui/widgets/custem_button_authentication.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = getIt<BookingsCubit>();
    final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
        GlobalKey<RefreshIndicatorState>();

    Future<void> refreshData() async {
      await cubit.getBookings();
    }

    // cubit.getBooking`s();
    return Scaffold(
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            horizantalSpace(25),
            CustemButtonAuthentication(
              text: 'Explore more',
              width: 310.w,
              height: 48.h,
            ),
          ],
        ),
        body: RefreshIndicator(
          key: refreshIndicatorKey,
          onRefresh: refreshData,
          child: Column(
            children: [
              SearchBarTop(), // Non-scrollable header
              Expanded(
                child: ReservationItems(), // Scrollable content
              ),
              verticalSpace(50)
            ],
          ),
        ));
  }
}
