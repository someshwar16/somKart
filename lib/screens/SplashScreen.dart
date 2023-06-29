import 'dart:async';
import 'package:flutter/material.dart';
import 'package:som_kart/const/AppColor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
//import 'package:som_kart/pages/main_home_page.dart';
import 'package:som_kart/screens/LoginScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), () => Get.to(SignIn()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.energy_yellow,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Som Kart",
                style: TextStyle(
                  fontSize: 44.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.loginPage,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              const CircularProgressIndicator(
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
