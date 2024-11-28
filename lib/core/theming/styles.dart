import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibm_flutter_final_project/core/theming/colors.dart';
import 'package:ibm_flutter_final_project/core/theming/font_wight_helper.dart';

class TextStyles {
  static TextStyle font24BlackSemiBold = TextStyle(
      fontSize: 24.sp,
      color: Colors.black,
      fontWeight: FontWeightHelper.semiBold);
  static TextStyle font10WhiteRegular = TextStyle(
      fontSize: 10.sp,
      color: Colors.white,
      fontWeight: FontWeightHelper.regular);
       static TextStyle font15WhiteRegular = TextStyle(
      fontSize: 15.sp,
      color: Colors.white,
      fontWeight: FontWeightHelper.regular);
  static TextStyle font16WhiteBold = TextStyle(
      fontSize: 16.sp, color: Colors.white, fontWeight: FontWeightHelper.bold);
  static TextStyle font10BlueRegular = TextStyle(
      fontSize: 10.sp,
      color: ColorsManager.mainBlue,
      fontWeight: FontWeightHelper.regular);
  static TextStyle font18WhiteBold =
      TextStyle(fontSize: 18.sp, 
      color: Colors.white,
      fontWeight: FontWeight.bold);  
      static TextStyle font14GreyRegular =
      TextStyle(fontSize: 14.sp, 
      color: Colors.grey,
      fontWeight: FontWeightHelper.regular);   
       static TextStyle fonst18BlackBold =
      TextStyle(fontSize: 18.sp, 
      color: Colors.black,
      fontWeight: FontWeightHelper.bold);
      
         static TextStyle font22blackMeduim =
      TextStyle(fontSize: 20.sp, 
      color: ColorsManager.semiBlack,
      fontWeight: FontWeightHelper.meduim);
      static TextStyle font15GreyBold =
      TextStyle(fontSize: 15.sp, 
      color: ColorsManager.lightGrey,
      fontWeight: FontWeightHelper.bold);


}
 
   