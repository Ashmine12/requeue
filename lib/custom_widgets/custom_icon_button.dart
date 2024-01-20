import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomIconWithButton extends StatelessWidget {
  const CustomIconWithButton({super.key, required this.icon});
  final Widget icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 6.h,
      width: 15.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          8.sp,
        ),
      ),
      child: Center(child: icon),
    );
  }
}
