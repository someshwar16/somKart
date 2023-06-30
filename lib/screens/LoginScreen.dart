import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:som_kart/LoginTabs/LoginWelcome.dart';
import 'package:som_kart/screens/SignUp.dart';
//import 'package:som_kart/const/AppColor.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          "Sign In",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const LoginBody(),
            SizedBox(
              height: 20.h,
            ),
            const Text('New to Som Kart ? Create Account'),
            TextButton(
              onPressed: () {
                Get.to(const SignUp());
              },
              child: const Text(
                'Sign Up',
                style: TextStyle(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
