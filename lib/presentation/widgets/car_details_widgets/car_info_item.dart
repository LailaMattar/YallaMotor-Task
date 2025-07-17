import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
            Icon(icon, size: 18.sp, color: Colors.grey),
            SizedBox(width: 8.w),
            Text(label, style: TextStyle(color: Colors.grey, fontSize: 14.sp)),
          ],
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 16.h),
      ],
    );
  }
} 