import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CarImageCarousel extends StatefulWidget {
  final List<String> carImages;

  const CarImageCarousel({
    Key? key,
    required this.carImages,
  }) : super(key: key);

  @override
  State<CarImageCarousel> createState() => _CarImageCarouselState();
}

class _CarImageCarouselState extends State<CarImageCarousel> {
  int _currentImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Responsive design - detect tablet vs mobile
        bool isTablet = constraints.maxWidth > 768;
        double imageHeight = isTablet ? 650 : 300.h;
        BoxFit imageFit = isTablet ? BoxFit.contain : BoxFit.cover;

        // If no images available, show placeholder
        if (widget.carImages.isEmpty) {
          return Container(
            height: imageHeight,
            margin: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              color: Colors.grey[200],
            ),
            child: const Center(
              child: Icon(Icons.directions_car, size: 64, color: Colors.grey),
            ),
          );
        }

        return Container(
          height: imageHeight,
          child: Stack(
            children: [
              PageView.builder(
                itemCount: widget.carImages.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentImageIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      color: Colors.grey[200],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: widget.carImages[index].isNotEmpty
                          ? CachedNetworkImage(
                              imageUrl: widget.carImages[index],
                              fit: imageFit,
                              placeholder: (context, url) => Container(
                                color: Colors.grey[200],
                                child: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                              errorWidget: (context, url, error) => const Center(
                                child: Icon(Icons.directions_car, size: 64, color: Colors.grey),
                              ),
                            )
                          : const Center(
                              child: Icon(Icons.directions_car, size: 64, color: Colors.grey),
                            ),
                    ),
                  );
                },
              ),
          // Image indicator - only show if more than one image
          if (widget.carImages.length > 1)
            Positioned(
              top: 20.h,
              right: 30.w,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  '${_currentImageIndex + 1} / ${widget.carImages.length}',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      );
      },
    );
  }
} 