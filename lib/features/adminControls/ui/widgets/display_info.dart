// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibm_flutter_final_project/core/theming/styles.dart';
import 'package:ibm_flutter_final_project/core/widgets/image_network_widget.dart';
import 'package:ibm_flutter_final_project/features/adminControls/data/models/book.dart';

class DisplayInfo extends StatelessWidget {
  final BookModel? bookModel;
  const DisplayInfo({
    Key? key,
    this.bookModel,
  }) : super(key: key);

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
                bookModel?.roomImage != null
                    ? ImageNetworkWidget(
                        imageLink: bookModel!.roomImage!,
                        hight: 201.h,
                        width: 358.w)
                    : Container(
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
                    bookModel?.roomTitle ?? "Meeting Room",
                    style: TextStyles.fonst18BlackBold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    bookModel?.WorkSpaceTitle ?? "Workspace - Office",
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
                  "${bookModel?.date} , ${bookModel?.startTime} \n${bookModel?.date} , ${bookModel?.endTime}" ??
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
                    "${bookModel?.price} EGP" ?? "1800 EGP",
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
