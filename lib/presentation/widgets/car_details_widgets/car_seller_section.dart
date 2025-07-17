import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/app_colors.dart';
import '../../../core/app_strings.dart';
import '../../../domain/entities/car_entity.dart';

class CarSellerSection extends StatelessWidget {
  final CarEntity car;

  const CarSellerSection({
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
            AppStrings.seller,
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12.h),
          Text(
            car.sellerName.isNotEmpty ? car.sellerName : AppStrings.unknownSeller,
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 4.h),
          Text(
            car.location,
            style: TextStyle(color: AppColors.textLight, fontSize: 12.sp),
          ),
        ],
      ),
    );
  }
} 