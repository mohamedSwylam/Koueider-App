import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/core/helper/spacing.dart';
import 'package:task/core/theming/colors.dart';
import 'package:task/features/presentation/screens/widgets/custom_button.dart';

Widget buildHeader() {
  return Row(
    children: [
      IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.arrow_back_ios,
          color: ColorsManger.blue,
          size: 18.sp,
        ),
      ),
      CustomButton(
        color: ColorsManger.blue,
        width: 141,
        height: 42,
        text: 'تسجيل الدخول',
        onPressed: () {},
        icon: Icons.person,
      ),
      horizontalSpace(150.w),
      Container(
        height: 42.h,
        width: 42.w,
        decoration: BoxDecoration(
          color: ColorsManger.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: IconButton(
          icon: Icon(
            Icons.search,
            color: ColorsManger.blue,
          ),
          onPressed: () {
            // Handle search action
          },
        ),
      ),
    ],
  );
}
