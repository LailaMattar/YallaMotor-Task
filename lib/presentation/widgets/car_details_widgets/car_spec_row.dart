import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/app_colors.dart';

class CarSpecRow extends StatelessWidget {
  final String label;
  final String value;

  const CarSpecRow({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(color: AppColors.textLight, fontSize: 14.sp),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
} 