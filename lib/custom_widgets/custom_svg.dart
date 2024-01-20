import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

class CustomSvg extends StatelessWidget {
  const CustomSvg({
    super.key,
    required this.svgPath,
    this.height,
    this.width,
    this.padding,
  });

  final String svgPath;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: SvgPicture.asset(
        svgPath,
        height: height ?? 16.sp,
        width: width ?? 16.sp,
      ),
    );
  }
}
