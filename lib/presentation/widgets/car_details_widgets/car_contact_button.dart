import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
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
        'Hi! I am interested in your ${car.title} (${car.year}) listed for ${car.currency} ${car.price}. Is it still available?');

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
            backgroundColor: const Color(0xFF25D366),
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
                        content: Text('WhatsApp is not installed or failed to open'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
              : () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('No WhatsApp number available for this car'),
                      backgroundColor: Colors.orange,
                    ),
                  );
                },
          icon: Icon(Icons.message, color: Colors.white),
          label: Text(
            car.whatsappNumber.isNotEmpty 
                ? 'Contact via WhatsApp' 
                : 'No Contact Available',
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }
} 