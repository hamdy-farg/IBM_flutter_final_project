import 'package:flutter/material.dart';
import 'package:ibm_flutter_final_project/features/add_new_workspace/data/model/add_new_workspace.dart';
import 'package:ibm_flutter_final_project/features/adminControls/ui/widgets/custem_reservation_item.dart';

class ReservationItems extends StatelessWidget {
  final List<AddNewWorkspaces> addNewWorkspace = [
    AddNewWorkspaces(
        itemName: 'Hilton San Francisco Union Square',
        hours: 'Hours: 5:00 pm to 7:00 pm',
        date: 'Date: Jan 7 , 2024  ',
        imagePath: '',
        price: '3.0',
        statues: 'Approved'),
    AddNewWorkspaces(
        itemName: 'Hilton San Francisco Union Square',
        hours: 'Hours: 5:00 pm to 7:00 pm',
        date: 'Date: Jan 7 , 2024  ',
        imagePath: '',
        price: '3.0',
        statues: 'Rejected'),
    AddNewWorkspaces(
        itemName: 'Hilton San Francisco Union Square',
        hours: 'Hours: 5:00 pm to 7:00 pm',
        date: 'Date: Jan 7 , 2024  ',
        imagePath: '',
        price: '3.0',
        statues: 'OnProgress'),
    AddNewWorkspaces(
        itemName: 'Hilton San Francisco Union Square',
        hours: 'Hours: 5:00 pm to 7:00 pm',
        date: 'Date: Jan 7 , 2024  ',
        imagePath: '',
        price: '3.0',
        statues: 'Approved'),
    AddNewWorkspaces(
        itemName: 'Hilton San Francisco Union Square',
        hours: 'Hours: 5:00 pm to 7:00 pm',
        date: 'Date: Jan 7 , 2024  ',
        imagePath: '',
        price: '3.0',
        statues: 'Rejected'),
    AddNewWorkspaces(
        itemName: 'Hilton San Francisco Union Square',
        hours: 'Hours: 5:00 pm to 7:00 pm',
        date: 'Date: Jan 7 , 2024  ',
        imagePath: '',
        price: '3.0',
        statues: 'OnProgress'),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: addNewWorkspace.length,
      scrollDirection: Axis.vertical,
      physics: const AlwaysScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final entry = addNewWorkspace[index];
        return CustemReservationItem(
          itemName: entry.itemName,
          date: entry.date,
          hours: entry.hours,
          ptice: entry.price,
          statues: entry.statues,
        );
      },
    );
  }
}
