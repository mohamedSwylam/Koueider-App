import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/core/theming/colors.dart';
import 'package:task/core/theming/font_weight.dart';

class TextStyles {
  static TextStyle font14WhiteSemiBold = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWightHelper.semibold,
    color: Colors.white,
  );

  static TextStyle font21BlackBold = TextStyle(
    fontSize: 21.sp,
    fontWeight: FontWightHelper.bold,
    color: ColorsManger.black,
  );
static TextStyle font16BlackBold = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWightHelper.bold,
    color: ColorsManger.black,
  );
  static TextStyle font16GrayMedium = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWightHelper.medium,
    color: ColorsManger.darkGray,
  );
    static TextStyle font10GreenBold = TextStyle(
    fontSize: 10.sp,
    fontWeight: FontWightHelper.bold,
    color: ColorsManger.green,
  );
   static TextStyle font21BlueBold = TextStyle(
    fontSize: 21.sp,
    fontWeight: FontWightHelper.bold,
    color: ColorsManger.blue,
  );
}
