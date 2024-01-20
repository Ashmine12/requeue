import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:requeue/constants/image_constant.dart';
import 'package:requeue/custom_widgets/custom_icon_button.dart';
import 'package:requeue/custom_widgets/custom_svg.dart';
import 'package:requeue/repository/auth_repository.dart';
import 'package:requeue/screens/home_screen.dart';
import 'package:requeue/screens/sign_up_screen.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  Future<void> loginUser(String phoneNumber, String password) async {
    try {
      setState(() {
        isLoading = true;
      });

      Map<String, dynamic>? loginResponse =
          await AuthRepository.loginUser(phoneNumber, password);

      if (loginResponse != null) {
        String userToken = loginResponse['token'];

        if (loginResponse.containsKey('user') &&
            loginResponse['user'] is Map<String, dynamic> &&
            loginResponse['user'].containsKey('client_id')) {
          int clientID = loginResponse['user']['client_id'];
          Navigator.of(context).push(MaterialPageRoute(
            builder: (_) =>
                HomeScreen(userToken: userToken, clientId: clientID),
          ));
        } else {
          debugPrint(
              'Invalid login response structure. Missing user or client_id.');
        }
      }
    } catch (error) {
      debugPrint('Login failed: $error');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(92, 194, 224, 1),
              Color.fromRGBO(128, 92, 255, 1),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10.h,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 20.w,
                  ),
                  Image.asset(
                    Assets.logo,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Row(
                    children: [
                      Text(
                        'Skip',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.sp,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.sp),
                        child: CustomSvg(svgPath: Assets.arrow, height: 20.sp),
                      )
                    ],
                  )
                ],
              ),
              FittedBox(
                child: Container(
                  height: 40.h,
                  width: 80.w,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        10.sp,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 20.0.sp,
                      horizontal: 15.sp,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Login your account',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.sp),
                          child: TextFormField(
                            controller: userNameController,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 15.sp, horizontal: 8.sp),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'E-mail',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 12.sp,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.sp),
                                borderSide: const BorderSide(color: Colors.white),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.sp),
                                borderSide: const BorderSide(color: Colors.white),
                              ),
                              prefixIcon: Padding(
                                padding: EdgeInsets.all(8.sp),
                                child: const CustomSvg(svgPath: Assets.user),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.sp),
                                borderSide: const BorderSide(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 7.sp,
                            bottom: 5.sp,
                          ),
                          child: TextFormField(
                            controller: passwordController,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 15.sp, horizontal: 8.sp),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Password',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 12.sp,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.sp),
                                borderSide: const BorderSide(color: Colors.white),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.sp),
                                borderSide: const BorderSide(color: Colors.white),
                              ),
                              prefixIcon: Padding(
                                padding: EdgeInsets.all(8.sp),
                                child: const CustomSvg(svgPath: Assets.lock),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.sp),
                                borderSide: const BorderSide(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 9.sp),
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              'Forget your password?',
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.white,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            await loginUser(
                              userNameController.text,
                              passwordController.text,
                            );
                          },
                          child: Container(
                            height: 6.h,
                            width: 70.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.sp),
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color.fromRGBO(121, 92, 224, 1),
                                  Color.fromRGBO(78, 58, 173, 1),
                                ],
                              ),
                            ),
                            child: Center(
                              child: isLoading
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : Text(
                                      'Login',
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        color: Colors.white,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              RichText(
                text: TextSpan(
                  text: 'You don\'t have an account yet !   ',
                  children: [
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => SignUpScreen())),
                      text: 'Sign up',
                      style: TextStyle(
                        fontSize: 16.sp,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      endIndent: 5.sp,
                      indent: 30.sp,
                      height: 2.h,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.sp),
                    child: Text(
                      'login with',
                      style: TextStyle(fontSize: 16.sp, color: Colors.white),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      endIndent: 30.sp,
                      indent: 5.sp,
                      height: 2.h,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 3.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomIconWithButton(
                    icon: Image.asset(
                      Assets.google,
                    ),
                  ),
                  const CustomIconWithButton(
                    icon: CustomSvg(
                      svgPath: Assets.apple,
                    ),
                  ),
                  const CustomIconWithButton(
                    icon: CustomSvg(
                      svgPath: Assets.fb,
                    ),
                  ),
                  const CustomIconWithButton(
                    icon: CustomSvg(
                      svgPath: Assets.twitter,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
