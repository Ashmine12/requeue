import 'package:flutter/material.dart';
import 'package:requeue/constants/image_constant.dart';
import 'package:requeue/custom_widgets/custom_svg.dart';
import 'package:requeue/screens/profile_screen.dart';
import 'package:sizer/sizer.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key, required this.userToken});
  final String userToken;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(15.sp),
          topLeft: Radius.circular(15.sp),
        ),
        gradient: const LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color.fromRGBO(92, 194, 224, 0.7),
            Color.fromRGBO(128, 92, 255, 0.7),
          ],
        ),
      ),
      child: Column(
        children: [
          Divider(
            color: Colors.white,
            endIndent: 100.sp,
            indent: 100.sp,
            height: 8.h,
            thickness: 2.sp,
          ),
          Padding(
            padding: EdgeInsets.only(left: 15.sp),
            child: Row(
              children: [
                CircleAvatar(
                    maxRadius: 25.sp,
                    backgroundImage: NetworkImage(
                        'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg')),
                Padding(
                  padding: EdgeInsets.only(left: 20.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome',
                        style: TextStyle(color: Colors.white, fontSize: 15.sp),
                      ),
                      Text(
                        'Ashmine',
                        style: TextStyle(color: Colors.white, fontSize: 20.sp),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.white,
            endIndent: 20.sp,
            indent: 20.sp,
            height: 4.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.sp),
            child: Row(
              children: [
                const CustomSvg(svgPath: Assets.history),
                Padding(
                  padding: EdgeInsets.only(left: 10.sp),
                  child: Text(
                    'View Restaurants',
                    style: TextStyle(color: Colors.white, fontSize: 15.sp),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30.w),
                  child: const CustomSvg(svgPath: Assets.arrow),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.sp, top: 10.sp),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => ProfileScreen(
                          userToken: userToken,
                        ),),);
              },
              child: Row(
                children: [
                  const CustomSvg(svgPath: Assets.history),
                  Padding(
                    padding: EdgeInsets.only(left: 10.sp),
                    child: Text(
                      'View Profile',
                      style: TextStyle(color: Colors.white, fontSize: 15.sp),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 40.w),
                    child: const CustomSvg(svgPath: Assets.arrow),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
