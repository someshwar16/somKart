import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:som_kart/const/firebase_const.dart';

class AuthController extends GetxController {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  //login method
  Future<UserCredential?> loginMethod({context}) async {
    UserCredential? userCredential;

    try {
      await auth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error", e.toString());
    }
    return userCredential;
  }

  //SignUp Function

  Future<UserCredential?> signUpMethod({email, password, context}) async {
    UserCredential? userCredential;

    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error", e.toString());
    }
    return userCredential;
  }

  //Storing data method

  storeUserData({name, password, email}) async {
    DocumentReference store =
        await firestore.collection(usersCollection).doc(currentUser!.uid);
    store.set({
      'name': name,
      'password': password,
      'email': email,
      'image': '',
      'id': currentUser!.uid,
    });
  }

  //signOut method

  signOut() async {
    try {
      await auth.signOut();
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
}
