import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibm_flutter_final_project/core/di/dependancy_injection.dart';
import 'package:ibm_flutter_final_project/features/adminControls/logic/bookingCubit/bookings_cubit.dart';
import 'package:ibm_flutter_final_project/features/adminControls/ui/widgets/custem_reservation_item.dart';

class ReservationItems extends StatelessWidget {
  final cubit = getIt<BookingsCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingsCubit, BookingsState>(
      bloc: cubit,
      builder: (context, state) {
        return ListView.builder(
          itemCount:
              (state is BookingsSuccessState) ? (state).bookedList.length : 0,
          scrollDirection: Axis.vertical,
          physics: const AlwaysScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final entry =
                (cubit.state as BookingsSuccessState).bookedList[index];
            return Column(
              children: [
                CustemReservationItem(
                  imageLink: entry.roomImage,
                  bookModel: entry,
                  itemName: entry.roomTitle,
                  date: entry.date,
                  startTime: entry.startTime,
                  endTime: entry.endTime,
                  price: entry.price.toString(),
                  statues: entry.status,
                ),
              ],
            );
          },
        );
      },
    );
  }
}
