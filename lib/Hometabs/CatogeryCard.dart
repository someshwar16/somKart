import 'package:flutter/material.dart';

class CatogeryCard extends StatelessWidget {
  const CatogeryCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 100,
          width: 390,
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Color(0xffF6F6F6),
                      ),
                      height: 40,
                      width: 40,
                      child: Image.asset(
                        'assets/icons/1.png',
                        height: 20,
                        width: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text('Categories'),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Color(0xffF6F6F6),
                      ),
                      height: 40,
                      width: 40,
                      child: Image.asset(
                        'assets/icons/2.png',
                        height: 20,
                        width: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text('Games'),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Color(0xffF6F6F6),
                      ),
                      height: 40,
                      width: 40,
                      child: Image.asset(
                        'assets/icons/3.png',
                        height: 20,
                        width: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text('Electornics'),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18.0, right: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Color(0xffF6F6F6),
                      ),
                      height: 40,
                      width: 40,
                      child: Image.asset(
                        'assets/icons/4.png',
                        height: 20,
                        width: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text('Foods'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
