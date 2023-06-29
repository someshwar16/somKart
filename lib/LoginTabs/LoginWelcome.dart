import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:som_kart/const/AppColor.dart';
import 'package:som_kart/const/custom_text_bar.dart';
import 'package:som_kart/controllers/firebase_controller.dart';
import 'package:som_kart/screens/main_home_page.dart';
import 'package:som_kart/screens/LoginScreen.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 30.0),
                  child: Text(
                    'Welcome Back',
                    style: TextStyle(
                      fontSize: 44,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  'Sign in with your email and password \n or continue with social media ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SignForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

signIn() async {
  try {
    final userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    );
    var authCredential = userCredential.user;
    if (authCredential != null) {
      Get.to(() => const MainHomePage());
    }
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      Get.snackbar('No user found', 'No user found for that email.');
    } else if (e.code == 'wrong-password') {
      Get.snackbar('Wrong Password', 'Wrong password provided for that user.');
    }
  }
}

var emailController = TextEditingController();
var passwordController = TextEditingController();

final _formKey = GlobalKey<FormState>();

class SignForm extends StatelessWidget {
  const SignForm({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Column(
          children: [
            customTextField(
                title: 'Email',
                hint: 'Enter your email',
                icon: 'assets/icons/mail.png',
                controller: emailController),
            SizedBox(height: 20.h),
            customTextField(
                title: 'Password',
                hint: 'Enter your password',
                icon: 'assets/icons/lock.png',
                controller: passwordController),
            SizedBox(height: 20.h),
            SizedBox(
              width: double.infinity,
              height: 56.0,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.energy_yellow,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28.0),
                  ),
                ),
                onPressed: () {
                  signIn();
                },
                child: const Text(
                  'Continue',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Row(
              children: [
                Checkbox(
                  value: false,
                  onChanged: (value) => {},
                ),
                const Text("Remeber me"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SocialCard(
                  icon: const Icon(Icons.facebook),
                  press: () {},
                ),
                SizedBox(width: 20.w),
                SocialCard(
                  icon: const Icon(Icons.mail),
                  press: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DefaultButton extends StatelessWidget {
  const DefaultButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56.0,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.energy_yellow,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28.0),
          ),
        ),
        onPressed: () async {},
        child: const Text(
          'Continue',
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}

class SocialCard extends StatelessWidget {
  const SocialCard({super.key, required this.icon, required this.press});

  final Widget icon;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // ignore: avoid_print
        print('tapped');
      },
      child: Container(
        padding: const EdgeInsets.all(12.0),
        height: 45.0,
        width: 45.0,
        decoration: const BoxDecoration(
          color: AppColors.energy_yellow,
          shape: BoxShape.circle,
        ),
        child: icon,
      ),
    );
  }
}
