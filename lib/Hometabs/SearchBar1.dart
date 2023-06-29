import 'package:flutter/material.dart';

class SearchBar1 extends StatelessWidget {
  const SearchBar1({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 50.0, left: 18.0),
          child: Container(
            height: 50,
            width: 300,
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.search,
                  size: 40.0,
                  color: Colors.grey,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                hintText: 'Search...',
                hintStyle: TextStyle(
                  fontSize: 20.0,
                  //fontFamily: 'Poppins',
                  color: Colors.grey[400],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 50.0, left: 10.0),
          child: Badge(
            label: Text('1'),
            child: Image.asset(
              'assets/icons/sb.png',
              height: 20,
              width: 20,
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: Image.asset(
            'assets/icons/dp.png',
            height: 20,
            width: 20,
          ),
        ),
      ],
    );
  }
}
