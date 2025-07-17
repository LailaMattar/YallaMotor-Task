import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/app_strings.dart';
import '../../../domain/entities/car_entity.dart';
import 'car_info_item.dart';
import 'car_spec_row.dart';

class CarSpecificationsSection extends StatelessWidget {
  final CarEntity car;

  const CarSpecificationsSection({
    Key? key,
    required this.car,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            children: [
              Expanded(
                child: CarInfoItem(
                  icon: Icons.local_gas_station,
                  label: AppStrings.fuelType,
                  value: car.fuel,
                ),
              ),
              Expanded(
                child: CarInfoItem(
                  icon: Icons.directions_car,
                  label: AppStrings.bodyStyle,
                  value: car.body,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Text(
            AppStrings.specifications,
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 16.h),
        CarSpecRow(label: AppStrings.transmission, value: car.transmission),
        CarSpecRow(label: AppStrings.engineCC, value: car.engineCC),
        CarSpecRow(label: AppStrings.mileage, value: AppStrings.formatMileage(car.mileage)),
        CarSpecRow(label: AppStrings.color, value: car.color),
        CarSpecRow(label: AppStrings.seats, value: car.seats),
        CarSpecRow(label: AppStrings.doors, value: car.doors),
      ],
    );
  }
} 