import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:som_kart/LoginTabs/LoginWelcome.dart';
import 'package:som_kart/const/AppColor.dart';
import 'package:som_kart/const/custom_text_bar.dart';
import 'package:som_kart/screens/NavBarPages/home.dart';
import 'package:som_kart/screens/SplashScreen.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController? nameController;
  TextEditingController? phoneController;
  TextEditingController? ageController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Profile'),
        centerTitle: true,
        backgroundColor: AppColors.loginPage,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(FirebaseAuth.instance.currentUser!.email)
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  var data = snapshot.data;
                  if (data == null) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return setDataToTextField(data);
                }),
          ),
        ),
      ),
    );
  }

  UpdateData() {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return users
        .doc(FirebaseAuth.instance.currentUser!.email)
        .update({
          'name': nameController!.text,
          'phone_no': phoneController!.text,
          'age': ageController!.text,
        })
        .then((value) => Get.snackbar('Updated', "User Updated"))
        .catchError(
            (error) => Get.snackbar('Failed', "Failed to update user: $error"));
  }

  setDataToTextField(data) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 50.r,
          backgroundImage: AssetImage('assets/icons/user.png'),
        ),
        SizedBox(
          height: 20.0.h,
        ),
        TextFormField(
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(28.0),
              borderSide: const BorderSide(color: Colors.black),
              gapPadding: 10.0,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(28.0),
              borderSide: const BorderSide(color: Colors.black),
              gapPadding: 10.0,
            ),
          ),
          controller: nameController =
              TextEditingController(text: data['name']),
        ),
        SizedBox(
          height: 10.h,
        ),
        TextFormField(
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(28.0),
              borderSide: const BorderSide(color: Colors.black),
              gapPadding: 10.0,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(28.0),
              borderSide: const BorderSide(color: Colors.black),
              gapPadding: 10.0,
            ),
          ),
          controller: phoneController =
              TextEditingController(text: data['phone_no']),
        ),
        SizedBox(
          height: 10.h,
        ),
        TextFormField(
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28.0),
                borderSide: const BorderSide(color: Colors.black),
                gapPadding: 10.0,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28.0),
                borderSide: const BorderSide(color: Colors.black),
                gapPadding: 10.0,
              ),
            ),
            controller: ageController =
                TextEditingController(text: data['age'])),
        SizedBox(
          height: 10.h,
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
              UpdateData();
            },
            child: const Text(
              'Update',
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        SizedBox(
          width: double.infinity,
          height: 56.0,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28.0),
              ),
            ),
            onPressed: () {
              FirebaseAuth.instance
                  .signOut()
                  .then((value) => Get.offAll(() => const SplashScreen()));
            },
            child: const Text(
              'Sign Out',
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
        ),
      ],
    );
  }
}
