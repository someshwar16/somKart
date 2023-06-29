import 'package:flutter/material.dart';

class DiscountCard extends StatelessWidget {
  const DiscountCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      width: double.infinity,
      //height: 90,
      decoration: BoxDecoration(
        color: const Color(0xFF4A3298),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: const Text.rich(
        TextSpan(
          text: "A summer Surprise\n",
          style: TextStyle(color: Colors.white),
          children: [
            TextSpan(
              text: "Cashback 20%",
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
