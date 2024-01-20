import 'package:flutter/material.dart';
import 'package:requeue/constants/color_constant.dart';
import 'package:requeue/constants/image_constant.dart';
import 'package:requeue/custom_widgets/Custom_button.dart';
import 'package:requeue/custom_widgets/custom_svg.dart';
import 'package:requeue/repository/resturant_repository.dart';
import 'package:sizer/sizer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.userToken});
  final String userToken;
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<String> restaurantLogos = [];
  List<String> restaurantName = [];
  RestaurantRepository? restaurantDataFetcher;
  @override
  void initState() {
    super.initState();
    restaurantDataFetcher = RestaurantRepository(userToken: widget.userToken);
    fetchRestaurantData();
  }

  Future<void> fetchRestaurantData() async {
    try {
      List<RestaurantInfo> restaurants =
          await restaurantDataFetcher!.fetchRestaurantData();
      setState(() {
        restaurantLogos = restaurants.map((info) => info.logoUrl).toList();
        restaurantName = restaurants.map((info) => info.name).toList();
      });
    } catch (error) {
      debugPrint('Error during restaurant data fetch: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                width: double.maxFinite,
                height: 15.h,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Color.fromRGBO(92, 194, 224, 1),
                      Color.fromRGBO(128, 92, 255, 1),
                    ],
                  ),
                ),
              ),
              Flexible(
                child: Container(
                  width: double.maxFinite,
                  height: double.maxFinite,
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 15.sp,
              right: 15.sp,
              top: 40.sp,
            ),
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    height: 10.h,
                    width: 90.w,
                    decoration: BoxDecoration(
                      color: Colors.white54,
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          10.sp,
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 8.sp,
                        horizontal: 15.sp,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: CustomSvg(
                              svgPath: Assets.backArrow,
                              height: 4.h,
                            ),
                          ),
                          Text(
                            'Profile',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.sp,
                            ),
                          ),
                          Image.asset(Assets.setting)
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      CircleAvatar(
                          maxRadius: 50.sp,
                          backgroundImage: NetworkImage(
                              'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg')),
                      Text(
                        'Ashmine Manik',
                        style: TextStyle(
                          fontSize: 16.sp,
                        ),
                      ),
                      Text(
                        '@ashmine',
                        style: TextStyle(
                          fontSize: 12.sp,
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      FittedBox(
                        child: Text(
                          'Obsessed with Fahim MD\'s, love to go\nshopping on weekends and loveee food #foodielife',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Text(
                                'Followers',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.sp,
                                  color: AppColors.black,
                                ),
                              ),
                              Text(
                                '45K',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: AppColors.black,
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                'Following',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.sp,
                                  color: AppColors.black,
                                ),
                              ),
                              Text(
                                '2.5K',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: AppColors.black,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CustomButton(
                            bgColor: AppColors.primaryColor,
                            title: 'Follow',
                            size: Size(50.w, 6.h),
                            titleColor: AppColors.whiteColor,
                            fontSize: 12.sp,
                          ),
                          CustomButton(
                            title: 'Message',
                            size: Size(30.w, 6.h),
                            bgColor: Colors.lightBlueAccent,
                            titleColor: AppColors.whiteColor,
                            fontSize: 12.sp,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CustomButton(
                              bgColor: AppColors.whiteColor,
                              title: 'Rates 135',
                              size: Size(40.w, 4.h),
                              titleColor: Colors.black54,
                              fontSize: 12.sp,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.sp),
                              child: CustomButton(
                                title: 'Visited 358',
                                size: Size(40.w, 4.h),
                                fontSize: 12.sp,
                              ),
                            ),
                            CustomButton(
                              title: 'Favorite Restaurants',
                              size: Size(50.w, 4.h),
                              bgColor: AppColors.whiteColor,
                              titleColor: Colors.black54,
                              fontSize: 12.sp,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 60.h,
                        child: ListView.builder(
                            itemCount: restaurantLogos.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.sp),
                                child: Container(
                                  height: 15.h,
                                  width: 90.w,
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 0.5,
                                          blurRadius: 3,
                                          offset: Offset(
                                            0,
                                            4,
                                          ),
                                        ),
                                      ],
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.circular(8.sp)),
                                  child: FittedBox(
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(10.sp),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15.sp),
                                            child:  Image.network(
                                              restaurantLogos[index],
                                              height: 12.h,
                                              width: 30.w,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              restaurantName[index],
                                              style: TextStyle(fontSize: 18.sp),
                                            ),
                                            Text(
                                              'The Chocolate Bar',
                                              style: TextStyle(fontSize: 12.sp),
                                            ),
                                            Text(
                                              'Full',
                                              style: TextStyle(fontSize: 10.sp),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              right: 8.sp, top: 50.sp),
                                          child: const Row(
                                            children: [
                                              CustomSvg(svgPath: Assets.star),
                                              Text('4.5')
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
