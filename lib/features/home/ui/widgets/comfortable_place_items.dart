import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibm_flutter_final_project/core/helpers/spacing.dart';
import 'package:ibm_flutter_final_project/core/theming/styles.dart';
import 'package:ibm_flutter_final_project/features/home/data/model/work_spaces.dart';
import 'package:ibm_flutter_final_project/features/home/ui/widgets/comfortable_place_iems_button.dart';
import 'package:ibm_flutter_final_project/features/home/ui/widgets/favourite_icon_changer.dart';

class ComfortablePlaceItems extends StatelessWidget {
  final List<ComfortablePlacesItems> comfortablePlacesItems = [
    ComfortablePlacesItems(
        imagePath: '',
        itemName: 'Titen Office Center',
        location: 'cairo ,nacer city',
        price: '3.0'),
    ComfortablePlacesItems(
        imagePath: '',
        itemName: 'Titen Office Center',
        location: 'cairo ,nacer city',
        price: '3.0'),
    ComfortablePlacesItems(
        imagePath: '',
        itemName: 'Titen Office Center',
        location: 'cairo ,nacer city',
        price: '3.0'),
    ComfortablePlacesItems(
        imagePath: '',
        itemName: 'Titen Office Center',
        location: 'cairo ,nacer city',
        price: '3.0'),
    ComfortablePlacesItems(
        imagePath: '',
        itemName: 'Titen Office Center',
        location: 'cairo ,nacer city',
        price: '3.0'),
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 245.h,
      child: ListView.builder(
          itemCount: comfortablePlacesItems.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final entry = comfortablePlacesItems[index];
            return CustemConfortablePlace(
              itemName: entry.itemName,
              location: entry.location,
              price: entry.price,
            );
          }),
    );
  }
}

class CustemConfortablePlace extends StatelessWidget {
  final String? price;
  final String? itemName;
  final String? imagePath;
  final String? location;

  const CustemConfortablePlace(
      {super.key, this.price, this.itemName, this.imagePath, this.location});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 4,
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              // Image Section
              Container(
                width: 80.w,
                height: 92.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: AssetImage(
                        imagePath ?? 'assets/images/roomsnearby.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Text and Info Section
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(itemName ?? "Women's leadership \n conference",
                          style: TextStyles.font16BlackBold),
                      ComfortablePlaceIemsButton(),
                    ],
                  ),
                ),
              ),
              // Price Section
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ColorChangingIcon(),
                  Text(price ?? "3.0", style: TextStyles.font13PurbleSemiBold),
                  Text("EGP/Hour", style: TextStyles.font14GreyRegular),
                ],
              ),
            ],
          ),
        ),
        verticalSpace(20),
      ],
    );
    ;
  }
}
