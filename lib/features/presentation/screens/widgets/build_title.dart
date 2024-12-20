import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/core/theming/colors.dart';
import 'package:task/core/theming/style.dart';

Widget buildTitle() {
  return Row(
    children: [
      Text(
        'حلويات غربية',
        style: TextStyles.font21BlackBold,
      ),
      IconButton(
        icon: Icon(
          Icons.keyboard_arrow_down,
          color: ColorsManger.black,
          size: 30.sp,
        ),
        onPressed: () {
          // Handle search action
        },
      ),
    ],
  );
}
