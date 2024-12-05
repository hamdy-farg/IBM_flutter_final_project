import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibm_flutter_final_project/core/di/dependancy_injection.dart';
import 'package:ibm_flutter_final_project/core/helpers/spacing.dart';
import 'package:ibm_flutter_final_project/features/adminControls/logic/bookingCubit/bookings_cubit.dart';
import 'package:ibm_flutter_final_project/features/adminControls/ui/widgets/reservation_items.dart';
import 'package:ibm_flutter_final_project/features/adminControls/ui/widgets/search_bar.dart';

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
        body: SafeArea(
      child: RefreshIndicator(
        key: refreshIndicatorKey,
        onRefresh: refreshData,
        child: Column(
          children: [
            verticalSpace(20),
            SearchBarTop(), // Non-scrollable header
            BlocBuilder<BookingsCubit, BookingsState>(
              bloc: cubit,
              builder: (context, state) {
                return Expanded(
                    child: (state is BookingsIsLoadingState)
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : (state is BookingsSuccessState)
                            ? state.bookedList.length == 0
                                ? Center(
                                    child: Text(
                                        "you haven't any booking unitel now"))
                                : ReservationItems()
                            : Center(
                                child: Text(""),
                              ) // Scrollable content
                    );
              },
            ),
          ],
        ),
      ),
    ));
  }
}
