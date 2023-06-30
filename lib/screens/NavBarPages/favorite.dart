import 'package:flutter/material.dart';
import 'package:som_kart/const/AppColor.dart';

class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.loginPage,
        automaticallyImplyLeading: false,
        title: Text('Favorite'),
      ),
      body: Container(),
    );
  }
}
