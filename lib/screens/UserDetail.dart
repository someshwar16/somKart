import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:som_kart/const/AppColor.dart';
import 'package:som_kart/const/custom_text_bar.dart';
import 'package:som_kart/screens/main_home_page.dart';

class UserDetail extends StatefulWidget {
  const UserDetail({super.key});

  @override
  State<UserDetail> createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  sendUserToDB() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    var currentUser = auth.currentUser;

    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return users
        .doc(currentUser!.email)
        .set({
          'name': nameController.text,
          'phone_no': phoneController.text,
          'gender': genderController.text,
          'age': ageController.text,
        })
        .then((value) => Get.offAll(const MainHomePage()))
        .catchError(
            // ignore: invalid_return_type_for_catch_error
            (error) => Get.snackbar('Failed', "Failed to add user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "User Detail",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Submit your details',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 10.0,
            ),
            const Text(
              'We will not share your details with anyone',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.normal,
                color: Colors.grey,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            customTextField(
                title: 'Name',
                hint: 'Enter your name',
                icon: 'assets/icons/user.png',
                controller: nameController),
            const SizedBox(height: 10.0),
            customTextField(
                title: 'Phone No.',
                hint: 'Enter your phone number',
                icon: 'assets/icons/phone.png',
                controller: phoneController),
            const SizedBox(height: 10.0),
            customTextField(
                title: 'Gender',
                hint: 'Enter your gender',
                icon: 'assets/icons/gender.png',
                controller: genderController),
            const SizedBox(height: 10.0),
            customTextField(
                title: 'Age',
                hint: 'Enter your age',
                icon: 'assets/icons/age.png',
                controller: ageController),
            const SizedBox(height: 10.0),
            SizedBox(
              width: double.infinity,
              height: 56.0,
              child: Padding(
                padding: const EdgeInsets.only(right: 20.0, left: 20.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.energy_yellow,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28.0),
                    ),
                  ),
                  onPressed: () {
                    sendUserToDB();
                  },
                  child: const Text(
                    'Continue',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
