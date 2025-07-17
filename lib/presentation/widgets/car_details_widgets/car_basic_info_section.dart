import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../domain/entities/car_entity.dart';
import 'car_info_item.dart';

class CarBasicInfoSection extends StatelessWidget {
  final CarEntity car;

  const CarBasicInfoSection({
    Key? key,
    required this.car,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: [
          Expanded(
            child: CarInfoItem(
              icon: Icons.calendar_today,
              label: 'Year',
              value: car.year,
            ),
          ),
          Expanded(
            child: CarInfoItem(
              icon: Icons.location_on,
              label: 'City',
              value: car.location,
            ),
          ),
        ],
      ),
    );
  }
} 