import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/app_colors.dart';
import '../../../core/app_strings.dart';
import '../../../domain/entities/car_entity.dart';

class CarContactButton extends StatelessWidget {
  final CarEntity car;

  const CarContactButton({Key? key, required this.car}) : super(key: key);

  Future<void> _openWhatsApp() async {
    if (car.whatsappNumber.isEmpty) {
      return;
    }

    // Format the phone number
    String phoneNumber = car.whatsappNumber.replaceAll(RegExp(r'[^\d+]'), ''); // Keep only digits and +
    
    // If the number doesn't start with + or country code, assume UAE (+971)
    if (!phoneNumber.startsWith('+') && !phoneNumber.startsWith('971')) {
      // Remove leading 0 if present and add UAE country code
      if (phoneNumber.startsWith('0')) {
        phoneNumber = phoneNumber.substring(1);
      }
      phoneNumber = '+971$phoneNumber';
    }

    // Remove + for URL formatting
    String formattedNumber = phoneNumber.replaceAll('+', '');

    // Create pre-filled message
    final String message = Uri.encodeComponent(
        AppStrings.whatsAppMessage(
          carTitle: car.title,
          carYear: car.year,
          currency: car.currency,
          price: car.price,
        ));

    // Platform-specific URLs
    var androidUrl = "whatsapp://send?phone=$formattedNumber&text=$message";
    var iosUrl = "https://wa.me/$formattedNumber?text=$message";
    
    print('WhatsApp URL is: ${Platform.isIOS ? iosUrl : androidUrl}');
    
    try {
      if (Platform.isIOS) {
        await launchUrl(Uri.parse(iosUrl));
      } else {
        await launchUrl(Uri.parse(androidUrl));
      }
    } on Exception {
      print('WhatsApp is not installed.');
      throw 'WhatsApp is not installed.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.buttonWhatsApp,
            padding: EdgeInsets.symmetric(vertical: 16.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
          onPressed: car.whatsappNumber.isNotEmpty 
              ? () async {
                  try {
                    await _openWhatsApp();
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(AppStrings.whatsAppNotInstalled),
                        backgroundColor: AppColors.snackBarError,
                      ),
                    );
                  }
                }
              : () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(AppStrings.noWhatsAppNumber),
                      backgroundColor: AppColors.snackBarWarning,
                    ),
                  );
                },
          icon: Icon(Icons.message, color: AppColors.buttonPrimaryText,size: 14.sp,),
          label: Text(
            car.whatsappNumber.isNotEmpty 
                ? AppStrings.contactViaWhatsApp
                : AppStrings.noContactAvailable,
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: AppColors.buttonPrimaryText),
          ),
        ),
      ),
    );
  }
} 