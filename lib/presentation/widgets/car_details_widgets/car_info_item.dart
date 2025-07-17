import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/app_colors.dart';

class CarInfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const CarInfoItem({
    Key? key,
    required this.icon,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 15.sp, color: AppColors.iconPrimary),
            SizedBox(width: 8.w),
                          Text(label, style: TextStyle(color: AppColors.textLight, fontSize: 12.sp)),
          ],
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 16.h),
      ],
    );
  }
} 