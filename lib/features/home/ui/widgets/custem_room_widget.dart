import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibm_flutter_final_project/core/helpers/spacing.dart';
import 'package:ibm_flutter_final_project/core/theming/colors.dart';
import 'package:ibm_flutter_final_project/features/home/ui/widgets/favourite_icon_changer.dart';

class CustemRoomWidget extends StatelessWidget {
  final String? price;
  final String? itemName;
  final String? imagePath;
  final String? location;

  const CustemRoomWidget(
      {super.key, this.price, this.itemName, this.imagePath, this.location});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 98.h,
      width: 318.w,
      decoration: BoxDecoration(
        color: ColorsManager.mainWhite,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 4,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Section
          Container(
            width: 81.w,
            height: 92.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.horizontal(left: Radius.circular(10)),
              image: DecorationImage(
                image: AssetImage(imagePath ?? 'assets/images/roomsnearby.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          horizantalSpace(10),
          // Text and Info Section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  itemName ?? "Women's leadership \n conference",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    verticalSpace(60),
                    Icon(
                      Icons.location_on,
                      color: Colors.grey[600],
                      size: 16,
                    ),
                    Text(
                      location ?? "Cairo, Elshourouk city",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Price Section
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: ColorChangingIcon(),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Text(
                  price ?? "3.0",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[700],
                  ),
                ),
              ),
              Text(
                "EGP/Hour",
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
