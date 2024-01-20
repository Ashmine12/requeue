import 'package:flutter/material.dart';
import 'package:requeue/constants/color_constant.dart';
import 'package:requeue/constants/image_constant.dart';
import 'package:requeue/custom_widgets/Custom_button.dart';
import 'package:requeue/custom_widgets/custom_svg.dart';
import 'package:requeue/repository/resturant_repository.dart';
import 'package:requeue/screens/side_menu.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen(
      {super.key, required this.userToken, required this.clientId});
  final String userToken;
  final int clientId;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showSideMenu = false;
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                showSideMenu = !showSideMenu;
                              });
                            },
                            child: CustomSvg(
                              svgPath: Assets.more,
                              height: 10.h,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: 15.sp,
                              left: 20.sp,
                            ),
                            child: Text(
                              'Restaurants',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (showSideMenu)
                    SizedBox(
                        height: 100.h,
                        child: SideMenu(
                          userToken: widget.userToken,
                        ))
                  else
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CustomButton(
                              title: 'Dine in',
                              size: Size(30.w, 6.h),
                              fontSize: 12.sp,
                            ),
                            CustomButton(
                              title: 'PickUp',
                              size: Size(30.w, 6.h),
                              bgColor: AppColors.whiteColor,
                              titleColor: Colors.black54,
                              fontSize: 12.sp,
                            ),
                          ],
                        ),
                        SizedBox(
                            height: 80.h,
                            child: ListView.builder(
                                itemCount: restaurantLogos.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 8.sp),
                                    child: Container(
                                      height: 15.h,
                                      width: 90.w,
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 0.5,
                                              blurRadius: 3,
                                              offset: const Offset(
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
                                                    BorderRadius.circular(
                                                        15.sp),
                                                child: Image.network(
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
                                                  style: TextStyle(
                                                      fontSize: 18.sp),
                                                ),
                                                Text(
                                                  'The Chocolate Bar',
                                                  style: TextStyle(
                                                      fontSize: 12.sp),
                                                ),
                                                Text(
                                                  'Full',
                                                  style: TextStyle(
                                                      fontSize: 10.sp),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  right: 8.sp, top: 50.sp),
                                              child: Row(
                                                children: [
                                                  CustomSvg(
                                                      svgPath: Assets.star),
                                                  Text('4.5')
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }))
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
