import 'package:flutter/material.dart';
import 'package:som_kart/Hometabs/CatogeryCard.dart';
import 'package:som_kart/Hometabs/DiscountCard.dart';
import 'package:som_kart/Hometabs/SearchBar1.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          SearchBar1(),
          Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: DiscountCard(),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 0.0),
            child: CatogeryCard(),
          ),
        ],
      ),
    );
  }
}
