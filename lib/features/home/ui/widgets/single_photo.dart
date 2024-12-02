// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibm_flutter_final_project/core/theming/colors.dart';
import 'package:ibm_flutter_final_project/core/theming/styles.dart';
import 'package:ibm_flutter_final_project/features/home/ui/widgets/favourite_icon_changer.dart';

class SinglePhoto extends StatelessWidget {
  final String? imageLink;
  final String? title;
  const SinglePhoto({
    Key? key,
    this.imageLink,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 222,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: imageLink != null
                      ? NetworkImage(imageLink!)
                      : AssetImage("assets/images/workspace.jpg"),
                  fit: BoxFit.cover)),
        ),
        Padding(
          padding: const EdgeInsets.all(30).h,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        size: 30,
                        Icons.arrow_back_outlined,
                        color: ColorsManager.mainWhite,
                      )),
                  Container(
                    width: 38,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.black87.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(child: ColorChangingIcon()),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  title ?? "Titen Office",
                  style: TextStyles.font20WhiteBold,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 160).h,
          child: Center(
            child: Container(
              width: 150,
              height: 35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.black87.withOpacity(0.5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.location_on_sharp,
                    color: Colors.white,
                  ),
                  Text("Cairo,Nasr City", style: TextStyles.font15WhiteRegular)
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
