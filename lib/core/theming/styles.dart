import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibm_flutter_final_project/core/theming/colors.dart';
import 'package:ibm_flutter_final_project/core/theming/font_Wight_helper.dart';

class TextStyles {
  static TextStyle font35BlackMeduim = TextStyle(
      fontSize: 35.sp,
      fontWeight: FontWightHelper.meduim,
      color: ColorsManager.mainBlack);
  static TextStyle font24Black5Meduim = TextStyle(
      fontSize: 24.sp,
      fontWeight: FontWightHelper.meduim,
      color: ColorsManager.mainBlack);
  static TextStyle font16Black400Wight = TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWightHelper.regular,
      color: ColorsManager.mainBlack);
  static TextStyle font15BlackRegular = TextStyle(
      fontSize: 15.sp,
      fontWeight: FontWightHelper.regular,
      color: ColorsManager.mainBlack);
  static TextStyle font15PurbleRegular = TextStyle(
      fontSize: 15.sp,
      fontWeight: FontWightHelper.regular,
      color: ColorsManager.mainPurble);
  static TextStyle font20WhiteBold = TextStyle(
      fontSize: 20.sp,
      fontWeight: FontWightHelper.bold,
      color: ColorsManager.mainWhite);
  static TextStyle font24BlackBold = TextStyle(
      fontSize: 24.sp,
      fontWeight: FontWightHelper.bold,
      color: ColorsManager.mainBlack);
}
