import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CarContactButton extends StatelessWidget {
  const CarContactButton({Key? key}) : super(key: key);

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
          onPressed: () {
            // TODO: Implement WhatsApp contact functionality
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Contact functionality will be implemented')),
            );
          },
          icon: Icon(Icons.message, color: Colors.white),
          label: Text(
            'Contact via WhatsApp',
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }
} 