import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:som_kart/LoginTabs/LoginWelcome.dart';
import 'package:som_kart/const/AppColor.dart';
import 'package:get/get.dart';
import 'package:som_kart/const/custom_text_bar.dart';

import 'package:som_kart/screens/main_home_page.dart';
import 'package:som_kart/screens/UserDetail.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Sign Up",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: SignUpBody(),
    );
  }
}

class SignUpBody extends StatefulWidget {
  const SignUpBody({super.key});

  @override
  State<SignUpBody> createState() => _SignUpBodyState();
}

class _SignUpBodyState extends State<SignUpBody> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Welcome',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                'Enter your details below to continue',
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              SignUpForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

var nameController = TextEditingController();
var emailController = TextEditingController();
var passwordController = TextEditingController();
signUp() async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);

    var authCredential = userCredential.user;
    if (authCredential != null) {
      Get.to(() => const UserDetail());
    }
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      Get.snackbar(
        'Password Weak',
        'The password provided is too weak.',
      );
    } else if (e.code == 'email-already-in-use') {
      Get.snackbar(
          'PLease Check', 'The account already exists for that email.');
    }
  } catch (e) {
    print(e);
  }
}

class _SignUpFormState extends State<SignUpForm> {
  //text controller

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: Column(
        children: [
          customTextField(
              title: 'Name',
              hint: 'Enter your name',
              icon: 'assets/icons/user.png',
              controller: nameController),
          const SizedBox(
            height: 10.0,
          ),
          customTextField(
              title: 'Email',
              hint: 'Enter your Email',
              icon: 'assets/icons/mail.png',
              controller: emailController),
          const SizedBox(
            height: 10.0,
          ),
          customTextField(
              title: 'Password',
              hint: 'Enter your Password',
              icon: 'assets/icons/lock.png',
              controller: passwordController),
          const SizedBox(
            height: 10.0,
          ),
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
                signUp();
              },
              child: const Text(
                'Continue',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
