import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibm_flutter_final_project/core/helpers/extensions.dart';
import 'package:ibm_flutter_final_project/core/helpers/spacing.dart';
import 'package:ibm_flutter_final_project/core/routing/routes.dart';
import 'package:ibm_flutter_final_project/core/theming/colors.dart';
import 'package:ibm_flutter_final_project/features/authentication/ui/sign_in_screen.dart';
import 'package:ibm_flutter_final_project/features/home/ui/single_item_screen.dart';
import 'package:ibm_flutter_final_project/features/home/ui/widgets/favourite_icon_changer.dart';

class SlidingWidget extends StatelessWidget {
  final String? itemName;
  final String? imagePath;
  final String? location;

  const SlidingWidget(
      {super.key, this.itemName, this.imagePath, this.location});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          context.pushNamed(Routes.singleItemScreen);
        },
        child: Container(
          width: 133.33.h,
          height: 198.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.sp),
            color: ColorsManager.mainWhite,
            boxShadow: [
              BoxShadow(
                color: ColorsManager.lightGrey,
                blurRadius: 6,
                spreadRadius: 3,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Image with overlay
              Stack(
                children: [
                  // Background Image
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(15),
                    ),
                    child: Image.asset(
                      imagePath ??
                          'assets/images/workspace.jpg', // Replace with your image asset
                      width: double.infinity,
                      height: 140.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Semi-transparent location container
                  Positioned(
                    bottom: 10,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black87.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.white,
                            size: 16,
                          ),
                          verticalSpace(6),
                          Text(
                            location ?? 'Cairo, Nasr City',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Bookmark Icon
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      width: 21.w,
                      height: 20.w,
                      decoration: BoxDecoration(
                        color: Colors.black87.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ColorChangingIcon(
                        size: 17.sp,
                      ),
                    ),
                  ),
                ],
              ),
              // Title below the image
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 8),
                child: Text(
                  itemName ?? 'Titen Office Center',
                  style: const TextStyle(
                    color: Color(0xff2C3E50),
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
