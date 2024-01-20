
import 'package:flutter/material.dart';
import 'package:requeue/constants/color_constant.dart';
import 'package:requeue/custom_widgets/Custom_button.dart';
import 'package:requeue/custom_widgets/custom_text_field.dart';
import 'package:requeue/models/user_model.dart';
import 'package:requeue/repository/auth_repository.dart';
import 'package:sizer/sizer.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _checked = false;

  TextEditingController usernameController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> signUp() async {
    await AuthRepository.signUp(
        userModel: UserModel(
      userName: usernameController.text,
      name: fullNameController.text,
      email: emailController.text,
      phoneNumber: phoneController.text,
      password: passwordController.text,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Sign up',
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: EdgeInsets.all(12.sp),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomTextField(
                label: 'Username',
                controller: usernameController,
              ),
              SizedBox(
                height: 3.h,
              ),
              CustomTextField(
                label: 'Full Name',
                controller: fullNameController,
              ),
              SizedBox(
                height: 3.h,
              ),
              CustomTextField(
                label: 'Email',
                controller: emailController,
              ),
              SizedBox(
                height: 3.h,
              ),
              CustomTextField(
                label: 'Phone',
                controller: phoneController,
              ),
              SizedBox(
                height: 3.h,
              ),
              CustomTextField(
                label: 'Password',
                obscureText: true,
                controller: passwordController,
              ),
              Padding(
                padding: EdgeInsets.all(10.sp),
                child: Row(
                  children: [
                    Transform.scale(
                      scale: 1.sp,
                      child: Checkbox(
                        side: const BorderSide(
                          color: Colors.grey,
                        ),
                        value: _checked,
                        onChanged: (value) {
                          setState(() {
                            _checked = value!;
                          });
                        },
                      ),
                    ),
                    Flexible(
                      child: RichText(
                        text: TextSpan(
                          text: 'I agree with the company\'s ',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14.0, // Set the font size
                          ),
                          children: [
                            TextSpan(
                              text: 'privacy policy\n',
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            const TextSpan(text: 'and\t'),
                            TextSpan(
                              text: 'terms of service',
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              CustomButton(
                title: 'Sign Up',
                onPressed: () async {
                  if (_checked) {
                    await signUp();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                            'Please agree to the terms before signing up.')));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
