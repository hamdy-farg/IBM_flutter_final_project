import 'package:flutter/material.dart';
import 'package:ibm_flutter_final_project/core/helpers/spacing.dart';
import 'package:ibm_flutter_final_project/features/add_new_workspace/data/model/add_new_workspace.dart';
import 'package:ibm_flutter_final_project/features/adminControls/ui/widgets/custem_reservation_item.dart';

class ReservationItems extends StatelessWidget {
  final List<AddNewWorkspaces> addNewWorkspace = [
    AddNewWorkspaces(
        itemName: 'Hilton San FranciscoUnion Square',
        price: '500',
        imagePath: '',
        statues: 'Approved',
        date: 'Jan 7 , 2024  ',
        startTime: '5:00 pm',
        endTime: ' 7:00 pm'),
    AddNewWorkspaces(
        itemName: 'Hilton San FranciscoUnion Square',
        price: '500',
        imagePath: '',
        statues: 'Rejected',
        date: 'Jan 7 , 2024  ',
        startTime: '5:00 pm',
        endTime: ' 7:00 pm'),
    AddNewWorkspaces(
        itemName: 'Hilton San FranciscoUnion Square',
        price: '500',
        imagePath: '',
        statues: 'OnProgress',
        date: 'Jan 7 , 2024  ',
        startTime: '5:00 pm',
        endTime: ' 7:00 pm'),
    AddNewWorkspaces(
        itemName: 'Hilton San FranciscoUnion Square',
        price: '500',
        imagePath: '',
        statues: 'Approved',
        date: 'Jan 7 , 2024  ',
        startTime: '5:00 pm',
        endTime: ' 7:00 pm'),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: addNewWorkspace.length,
      scrollDirection: Axis.vertical,
      physics: const AlwaysScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final entry = addNewWorkspace[index];
        return Column(
          children: [
            CustemReservationItem(
              itemName: entry.itemName,
              date: entry.date,
              startTime: entry.startTime,
              endTime: entry.endTime,
              price: entry.price,
              statues: entry.statues,
            ),
          ],
        );
      },
    );
  }
}
