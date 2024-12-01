import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibm_flutter_final_project/core/theming/styles.dart';
import 'package:ibm_flutter_final_project/features/add_new_workspace/data/model/add_new_workspace.dart';

class DisplayInfo extends StatelessWidget {
  List<BookedDetails> bookedDetails = [
    BookedDetails(
        itemName: 'Ninja Room',
        itemDescription: 'Workspace - Ninjago',
        date: 'Tue, Jan 25, 2022',
        startTime: '10:00 AM ',
        endTime: '1:00 AM',
        imagePath: '',
        price: '1800')
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 300.h,
            width: 358.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black87.withOpacity(0.1),
                    blurRadius: 10,
                    offset: Offset(5, 5),
                    spreadRadius: 3,
                  )
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 201.h,
                  width: 358.w,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/meeting.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    bookedDetails[0].itemName ?? "Meeting Room",
                    style: TextStyles.fonst18BlackBold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    bookedDetails[0].itemDescription ?? "Workspace - Office",
                    style: TextStyles.font18blueBold,
                  ),
                )
              ],
            ),
          ),
        ),
        Container(
          height: 120.h,
          width: 358.w,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black87.withOpacity(0.1),
                  blurRadius: 10,
                  offset: Offset(5, 5),
                  spreadRadius: 3,
                )
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Start & End Time",
                  style: TextStyles.fonst18BlackBold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "${bookedDetails[0].date} , ${bookedDetails[0].startTime} \n${bookedDetails[0].date} , ${bookedDetails[0].endTime}" ??
                      "Tue, Jan 25, 2022, 10:00 AM \n Tue, Jan 25, 2022, 1:00 AM ",
                  style: TextStyles.font18blueBold,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 90.h,
            width: 358.w,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black87.withOpacity(0.1),
                    blurRadius: 10,
                    offset: Offset(5, 5),
                    spreadRadius: 3,
                  )
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Payment Method",
                    style: TextStyles.fonst18BlackBold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Pay at Host",
                    style: TextStyles.font18blueBold,
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 90.h,
            width: 358.w,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black87.withOpacity(0.1),
                    blurRadius: 10,
                    offset: Offset(5, 5),
                    spreadRadius: 3,
                  )
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Price",
                    style: TextStyles.fonst18BlackBold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "${bookedDetails[0].price} EGP" ?? "1800 EGP",
                    style: TextStyles.font18blueBold,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
