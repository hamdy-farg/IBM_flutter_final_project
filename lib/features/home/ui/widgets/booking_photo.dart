import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibm_flutter_final_project/core/theming/colors.dart';
import 'package:ibm_flutter_final_project/core/theming/styles.dart';
import 'package:ibm_flutter_final_project/core/widgets/image_network_widget.dart';

class BookingPhoto extends StatefulWidget {
  String? imageLink;
  BookingPhoto({this.imageLink, super.key});

  @override
  State<BookingPhoto> createState() => _BookingPhotoState();
}

bool flag = false;

class _BookingPhotoState extends State<BookingPhoto> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.imageLink != null
            ? ImageNetworkWidget(
                imageLink: widget.imageLink!,
                hight: 222.h,
                width: double.infinity)
            : Container(
                width: double.infinity,
                height: 222,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/workspace.jpg"),
                        fit: BoxFit.cover)),
              ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back_outlined,
                        color: ColorsManager.mainWhite,
                      )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Titen Room",
                      style: TextStyles.font20WhiteBold,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 38,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                    child: InkWell(
                  onTap: () {
                    setState(() {
                      flag = !flag;
                    });
                  },
                  child: Icon(
                    Icons.bookmark_rounded,
                    color: flag ? ColorsManager.semitRed : Colors.grey,
                    size: 27.sp,
                  ),
                )),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
