import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/app_colors.dart';
import '../../../domain/entities/car_entity.dart';

class CarTitleSection extends StatelessWidget {
  final CarEntity car;

  const CarTitleSection({
    Key? key,
    required this.car,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            car.title,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.textSecondary,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            '${car.currency} ${_formatPrice(car.price)}',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  String _formatPrice(String price) {
    // Add commas to price for better readability
    final num = int.tryParse(price) ?? 0;
    return num.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }
} 