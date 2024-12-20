  import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/core/theming/colors.dart';

Widget buildCategories() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildCategoryChip('جميع الحلويات غربية', true),
          _buildCategoryChip('تورت', false),
          _buildCategoryChip('جاتوه', false),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(String label, bool isSelected) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: Chip(
        label: Text(label),
        backgroundColor: ColorsManger.lightBlue,
        labelStyle: TextStyle(
          color: isSelected ? ColorsManger.blue : ColorsManger.black,
        ),
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(26.sp),
      ),
      side: BorderSide(
          color: isSelected ? Colors.black : Colors.white, // Border color based on selection
          width: 1, // Border width
        ),
      ),
    );
  }

