import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibm_flutter_final_project/core/theming/colors.dart';
import 'package:ibm_flutter_final_project/core/theming/styles.dart';
import 'package:ibm_flutter_final_project/core/widgets/get_area_name.dart';
import 'package:ibm_flutter_final_project/core/widgets/image_network_widget.dart';
import 'package:ibm_flutter_final_project/features/home/ui/widgets/favourite_icon_changer.dart';

class SlidingWidget extends StatelessWidget {
  final String? itemName;
  final String? imagePath;
  final String? imageLink;
  final void Function()? onTap;
  final String? location;

  const SlidingWidget(
      {super.key,
      this.imageLink,
      this.itemName,
      this.imagePath,
      this.location,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: 133.33.h,
          height: 198.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.sp),
            color: ColorsManager.mainWhite,
            boxShadow: [
              BoxShadow(
                color: ColorsManager.lightGrey,
                blurRadius: 10,
                spreadRadius: 0.7,
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
                    child: imageLink != null
                        ? ImageNetworkWidget(
                            imageLink: imageLink!,
                            hight: 140.h,
                            width: double.infinity)
                        : Image.asset(
                            imagePath ??
                                'assets/images/workspace.jpg', // Replace with your image asset
                            width: double.infinity,
                            height: 140.h,
                            fit: BoxFit.cover,
                          ),
                  ),
                  // Semi-transparent location container
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      constraints: BoxConstraints(maxHeight: 30, maxWidth: 10),
                      decoration: BoxDecoration(
                        color: Colors.black87.withOpacity(0.5),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.white,
                            size: 16,
                          ),
                          Expanded(
                            child: getLocationText(
                              location: location ?? "",
                              textStyle: TextStyles.font10WhiteBold,
                            ),
                          )
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
              Align(
                alignment: Alignment.center,
                child: Text(itemName ?? 'Titen  Center',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles.font16BlackBold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
