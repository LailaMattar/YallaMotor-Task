import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../core/app_colors.dart';
import '../../core/app_strings.dart';
import '../../domain/entities/car_entity.dart';
import '../providers/car_provider.dart';
import '../widgets/car_details_widgets/car_image_carousel.dart';
import '../widgets/car_details_widgets/car_title_section.dart';
import '../widgets/car_details_widgets/car_basic_info_section.dart';
import '../widgets/car_details_widgets/car_specifications_section.dart';
import '../widgets/car_details_widgets/car_description_section.dart';
import '../widgets/car_details_widgets/car_seller_section.dart';
import '../widgets/car_details_widgets/car_contact_button.dart';

class CarDetailsPage extends StatelessWidget {
  final CarEntity car;

  const CarDetailsPage({Key? key, required this.car}) : super(key: key);

  // Get actual car images from the car data
  List<String> get carImages {
    // Use pictures from car data if available, otherwise fallback to single image
    if (car.pictures.isNotEmpty) {
      return car.pictures;
    } else if (car.image.isNotEmpty) {
      return [car.image];
    } else {
      return []; // No images available
    }
  }

  void _toggleFavorite(BuildContext context) async {
    try {
      // Get current state BEFORE toggling to show correct message
      final carProvider = context.read<CarProvider>();
      CarEntity currentCar = car;
      
      // Try to get the most recent state from provider
      try {
        currentCar = carProvider.cars.firstWhere((c) => c.id == car.id);
      } catch (e) {
        // Car not found in provider, use original car
        currentCar = car;
      }
      
      final bool isInFavorites = currentCar.isFavorite;
      
      await carProvider.toggleCarFavorite(car.id);
      
      // Show feedback to user based on the action that was performed
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isInFavorites
                ? AppStrings.removedFromFavorites
                : AppStrings.addedToFavorites,
          ),
          duration: const Duration(seconds: 2),
          backgroundColor: isInFavorites ? AppColors.snackBarNeutral : AppColors.snackBarSuccess,
        ),
      );
    } catch (e) {
      // Show error message if toggle fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppStrings.failedToUpdateFavoriteStatus),
          backgroundColor: AppColors.snackBarError,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CarProvider>(
      builder: (context, carProvider, child) {
        // Get the updated car from the provider's cars list
        CarEntity updatedCar = car; // Default to original car
        
        try {
          updatedCar = carProvider.cars.firstWhere((c) => c.id == car.id);
        } catch (e) {
          // Car not found in provider, use original car
          updatedCar = car;
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(AppStrings.carDetails, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.sp,)),
            backgroundColor: AppColors.background,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, size: 16.sp), // Set your desired size here
              onPressed: () {
                Navigator.of(context).maybePop(); // Or Navigator.pop(context)
              },
            ),
            elevation: 0,
                          foregroundColor: AppColors.textPrimary,
            actions: [
              IconButton(
                icon: Icon(
                  updatedCar.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: updatedCar.isFavorite ? AppColors.iconFavorite : AppColors.iconUnfavorite,
                  size: 28.h,
                ),
                onPressed: () => _toggleFavorite(context),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image Carousel Section
                CarImageCarousel(carImages: carImages),
                
                // Car Title and Price Section
                CarTitleSection(car: updatedCar),
                
                // Basic Info Section
                CarBasicInfoSection(car: updatedCar),
                
                // Specifications Section
                CarSpecificationsSection(car: updatedCar),
                
                // Description Section
                CarDescriptionSection(car: updatedCar),
                
                // Seller Section
                CarSellerSection(car: updatedCar),
                
                // Contact Button
                CarContactButton(car: updatedCar),
                
                SizedBox(height: 20.h),
              ],
            ),
          ),
        );
      },
    );
  }
}
