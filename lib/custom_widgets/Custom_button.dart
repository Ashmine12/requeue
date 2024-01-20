import 'package:flutter/material.dart';
import 'package:requeue/constants/color_constant.dart';
import 'package:sizer/sizer.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    super.key,
    required this.title,
    this.size,
    this.bgColor,
    this.titleColor,
    this.fontSize,
    this.onPressed,
  });
  final String title;
  Size? size;
  Color? bgColor;
  Color? titleColor;
  double? fontSize;
  void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed??(){},
      style: ElevatedButton.styleFrom(
          backgroundColor: bgColor ?? AppColors.primaryColor,
          fixedSize: size ?? Size(80.w, 6.h),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.sp))),
      child: Text(
        title,
        style: TextStyle(
            color: titleColor ?? AppColors.whiteColor,
            fontSize: fontSize ?? 15.sp),
      ),
    );
  }
}
