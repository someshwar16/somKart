import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:som_kart/const/AppColor.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.loginPage,
        automaticallyImplyLeading: false,
        title: const Text(
          'My Cart',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users-cart')
                .doc(FirebaseAuth.instance.currentUser!.email)
                .collection('items')
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot cart = snapshot.data!.docs[index];
                    return Card(
                      child: ListTile(
                        leading: Image.network(cart['images'][0]),
                        title: Text(cart['name']),
                        subtitle: Text(
                          "Rs." + cart['price'].toString(),
                          style: const TextStyle(
                              color: Colors.green, fontWeight: FontWeight.bold),
                        ),
                        trailing: CircleAvatar(
                          backgroundColor: AppColors.energy_yellow,
                          child: IconButton(
                            onPressed: () {
                              FirebaseFirestore.instance
                                  .collection('users-cart')
                                  .doc(FirebaseAuth.instance.currentUser!.email)
                                  .collection('items')
                                  .doc(cart.id)
                                  .delete();
                            },
                            icon: const Icon(Icons.delete),
                          ),
                        ),
                      ),
                    );
                  });
            }),
      ),
    );
  }
}
