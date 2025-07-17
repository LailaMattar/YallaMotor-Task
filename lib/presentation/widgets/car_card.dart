import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../domain/entities/car_entity.dart';
import '../pages/car_details.dart';

class CarCard extends StatelessWidget {
  final String image;
  final String title;
  final String price;
  final String year;
  final String location;
  final String fuel;
  final String body;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;
  final CarEntity car;

  const CarCard({
    Key? key,
    required this.image,
    required this.title,
    required this.price,
    required this.year,
    required this.location,
    required this.fuel,
    required this.body,
    required this.isFavorite,
    required this.onFavoriteToggle,
    required this.car,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use LayoutBuilder to adjust card styling based on available space
    return LayoutBuilder(
      builder: (context, constraints) {
        // Determine if this card is in a grid layout (less width available)
        final bool isInGrid = constraints.maxWidth < 400;
        
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CarDetailsPage(car: car),
              ),
            );
          },
          child: Card(
            margin: isInGrid 
                ? EdgeInsets.all(4.r) // Smaller margins for grid
                : EdgeInsets.symmetric(vertical: 8.h, horizontal: 4.w), // Original margins for list
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
            elevation: 2,
            child: Padding(
              padding: EdgeInsets.all(10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: Container(
                      width: double.infinity,
                      height: isInGrid ? 200.h : 300.h,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Stack(
                        children: [
                          image.isNotEmpty
                              ? CachedNetworkImage(
                                  imageUrl: image,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: isInGrid ? 200.h : 350.h,
                                  placeholder: (context, url) => Center(
                                    child: CircularProgressIndicator(
                                      value: null,
                                    ),
                                  ),
                                  errorWidget: (context, url, error) => Center(
                                    child: Icon(
                                      Icons.directions_car,
                                      size: 40.w,
                                      color: Colors.grey,
                                    ),
                                  ),
                                )
                              : Center(
                                  child: Icon(
                                    Icons.directions_car,
                                    size: 40.w,
                                    color: Colors.grey,
                                  ),
                                ),
                          Positioned(
                            top: 8.h,
                            right: 8.w,
                            child: IconButton(
                              icon: Icon(
                                isFavorite ? Icons.favorite : Icons.favorite_border,
                                color: isFavorite ? Colors.red : Colors.white,
                                size: 13.w,
                              ),
                              onPressed: onFavoriteToggle,
                              style: IconButton.styleFrom(
                                backgroundColor: Colors.black26,
                                shape: const CircleBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 13.h),
                  Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    price,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp, color: const Color(0xFF2986F6)),
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      Icon(Icons.calendar_today, size: 11.w, color: Colors.black54),
                      SizedBox(width: 4.w),
                      Text(year, style: TextStyle(color: Colors.black87, fontSize: 10.sp)),
                      SizedBox(width: 13.w),
                      Icon(Icons.location_on,size: 11.w, color: Colors.black54),
                      SizedBox(width: 4.w),
                      Text(location, style: TextStyle(color: Colors.black87, fontSize: 10.sp)),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Icon(Icons.local_gas_station, size: 11.w, color: Colors.black54),
                      SizedBox(width: 4.w),
                      Text(fuel, style: TextStyle(color: Colors.black87, fontSize: 10.sp)),
                      SizedBox(width: 13.w),
                      Icon(Icons.directions_car, size: 11.w, color: Colors.black54),
                      SizedBox(width: 4.w),
                      Text(body, style: TextStyle(color: Colors.black87, fontSize: 10.sp)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
} 