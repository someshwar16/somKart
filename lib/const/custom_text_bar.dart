import 'package:flutter/material.dart';
import 'package:som_kart/const/AppColor.dart';

Widget customTextField(
    {required String? title,
    required String? hint,
    controller,
    required String? icon}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            labelText: title,
            labelStyle: const TextStyle(color: AppColors.loginPage),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 42.0,
              vertical: 20.0,
            ),
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
            suffixIcon: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Image.asset(
                icon!,
                height: 10.0,
                width: 10.0,
                alignment: Alignment.centerRight,
              ),
            ),
            suffixIconColor: AppColors.loginPage,
          ),
        ),
      ),
    ],
  );
}

Widget customTextField1({
  required String? title,
  required String? hint,
  controller,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            labelText: title,
            labelStyle: const TextStyle(color: AppColors.loginPage),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 42.0,
              vertical: 20.0,
            ),
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
        ),
      ),
    ],
  );
}
