import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibm_flutter_final_project/core/helpers/extensions.dart';
import 'package:ibm_flutter_final_project/core/helpers/spacing.dart';
import 'package:ibm_flutter_final_project/core/routing/routes.dart';
import 'package:ibm_flutter_final_project/core/theming/colors.dart';
import 'package:ibm_flutter_final_project/core/theming/styles.dart';
import 'package:ibm_flutter_final_project/core/widgets/image_network_widget.dart';
import 'package:ibm_flutter_final_project/features/adminControls/data/models/book.dart';

class CustemReservationItem extends StatelessWidget {
  final BookModel? bookModel;
  final String? itemName;
  final String? date;
  final String? startTime;
  final String? endTime;
  final String? imagePath;
  final String? price;
  final String? statues;
  final String? imageLink;

  const CustemReservationItem({
    this.bookModel,
    super.key,
    this.itemName,
    this.imagePath,
    this.price,
    this.statues,
    this.date,
    this.startTime,
    this.endTime,
    this.imageLink,
  });

  @override
  Widget build(BuildContext context) {
    statues == 'OnProgress';
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 357.w,
          height: 250.h,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: ColorsManager.mainWhite,
              borderRadius: BorderRadius.circular(18),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(itemName ?? 'Hilton San Francisco \n Union Square',
                            style: TextStyles.font18blackbold),
                        verticalSpace(3),
                        Text(
                          "Date: ${date}" ?? 'Date: Jan 7, 2024',
                          style: TextStyles.font14greybold,
                        ),
                        Text(
                          'Hours: ${startTime} to ${endTime}  ' ??
                              'Hours: 5:00 pm to 7:00 pm',
                          style: TextStyles.font14greybold,
                        ),
                        SizedBox(height: 7),
                        Text(
                          "Price: ${price} EGP" ?? 'Price: 500 EGP',
                          style: TextStyles.font14bluebold,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 50),
                        child: imageLink != null
                            ? ImageNetworkWidget(
                                imageLink: imageLink ?? '',
                                hight: 118.h,
                                width: 118.w)
                            : Container(
                                height: 118.h,
                                width: 118.w,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                        image: AssetImage(imagePath ??
                                            "assets/images/mone.png"))),
                              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 30),
                              child: Text(
                                  "Status: ${statues}" ??
                                      "Status: ${statues == 'OnProgress'}",
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold)),
                            ),
                            horizantalSpace(5),
                            statues == "approved"
                                ? Icon(
                                    size: 14,
                                    Icons.circle,
                                    color: Colors.green,
                                  )
                                : statues == "rejected"
                                    ? Icon(
                                        size: 14,
                                        Icons.circle,
                                        color: Colors.red,
                                      )
                                    : Icon(
                                        size: 14,
                                        Icons.circle,
                                        color: Colors.yellow,
                                      )
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: InkWell(
                    onTap: () {
                      context.pushNamed(Routes.bookedDeatilsScreen,
                          arguments: bookModel);
                    },
                    child: ReservationButton()),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ReservationButton extends StatelessWidget {
  final String? text;

  const ReservationButton({super.key, this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      width: 358.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          colors: [
            ColorsManager.mainPurble,
            ColorsManager.mainPurble,
            ColorsManager.mainPurbleGradient,
          ],
        ),
      ),
      child: Center(
        child: Text(
          text ?? "Edit reservation and see details",
          style: TextStyles.font14WhiteBold,
        ),
      ),
    );
  }
}
