import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
                  label: 'Fuel Type',
                  value: car.fuel,
                ),
              ),
              Expanded(
                child: CarInfoItem(
                  icon: Icons.directions_car,
                  label: 'Body Style',
                  value: car.body,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Text(
            'Specifications',
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 16.h),
        CarSpecRow(label: 'Transmission', value: car.transmission),
        CarSpecRow(label: 'Engine CC', value: '2900cc'), // Mock data
        CarSpecRow(label: 'Mileage', value: '${car.mileage} km'),
        CarSpecRow(label: 'Color', value: car.color),
        CarSpecRow(label: 'Seats', value: '5'), // Mock data
        CarSpecRow(label: 'Doors', value: '5'), // Mock data
      ],
    );
  }
} 