import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import '../../../domain/entities/car_entity.dart';

class CarDescriptionSection extends StatelessWidget {
  final CarEntity car;

  const CarDescriptionSection({
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
            'Description',
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12.h),
          car.description.isNotEmpty 
              ? HtmlWidget(
                  car.description,
                  textStyle: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.black87,
                    height: 1.5,
                  ),
                )
              : Text(
                  'No description available for this vehicle.',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.black87,
                    height: 1.5,
                  ),
                ),
        ],
      ),
    );
  }
} 