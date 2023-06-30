import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:som_kart/const/AppColor.dart';
import 'package:som_kart/screens/NavBarPages/cart.dart';

class ProductDetail extends StatefulWidget {
  //const ProductDetail({super.key});
  var product;

  ProductDetail({this.product});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  var dotPosition = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 25.sp,
            ),
          ),
          actions: [
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users-fav')
                  .doc(FirebaseAuth.instance.currentUser!.email)
                  .collection('items')
                  .where('name', isEqualTo: widget.product['product-name'])
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                return IconButton(
                  onPressed: () {
                    snapshot.data!.docs.length == 0
                        ? addToFav()
                        : Get.snackbar("Already Added", 'Added Item to Fav');
                  },
                  icon: snapshot.data!.docs.length == 0
                      ? Icon(
                          Icons.favorite_border,
                          color: Colors.white,
                          size: 25.sp,
                        )
                      : Icon(
                          Icons.favorite,
                          color: Colors.white,
                          size: 25.sp,
                        ),
                );
              },
            ),
            IconButton(
              onPressed: () {
                Get.to(() => Cart());
              },
              icon: Icon(
                Icons.shopping_cart_outlined,
                color: Colors.white,
                size: 25.sp,
              ),
            ),
          ],
          elevation: 0,
          backgroundColor: AppColors.loginPage,
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 3.5,
                child: CarouselSlider(
                  items: widget.product['product-img']
                      .map<Widget>(
                        (item) => Container(
                          padding: const EdgeInsets.only(left: 3.0, right: 3.0),
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(10.r),
                            image: DecorationImage(
                              image: NetworkImage(item),
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  options: CarouselOptions(
                    autoPlay: true,
                    enlargeCenterPage: true,
                    viewportFraction: 0.8,
                    enlargeStrategy: CenterPageEnlargeStrategy.height,
                    onPageChanged: (index, CarouselPageChangedReason) {
                      setState(() {
                        dotPosition = index;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Center(
                child: DotsIndicator(
                  dotsCount: widget.product['product-img'].isEmpty
                      ? 1
                      : widget.product['product-img'].length,
                  position: dotPosition,
                  decorator: DotsDecorator(
                    activeColor: AppColors.loginPage,
                    color: AppColors.loginPage.withOpacity(0.5),
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                widget.product['product-name'],
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                height: 30.h,
                width: 60.h,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(5.r),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: Text(
                        '4.5',
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.white,
                      size: 20.sp,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                // ignore: prefer_interpolation_to_compose_strings
                "Rs.  " + widget.product['product-price'].toString() + "/-",
                style:
                    TextStyle(fontSize: 16.sp, fontWeight: FontWeight.normal),
              ),
              const SizedBox(
                height: 15.0,
              ),
              Text(
                'Description',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
                softWrap: true,
              ),
              Text(
                widget.product['product-description'],
                style: const TextStyle(
                  fontFamily: 'Comic Sans MS',
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                'Reviews',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Enter your review',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
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
                  onPressed: () => addToCart(),
                  child: const Text(
                    'Add to Cart',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future addToCart() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final currentUser = auth.currentUser;
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('users-cart');
    return collectionRef.doc(currentUser!.email).collection('items').doc().set({
      'name': widget.product['product-name'],
      'price': widget.product['product-price'],
      'images': widget.product['product-img'],
    });
  }

  Future addToFav() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final currentUser = auth.currentUser;
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('users-fav');
    return collectionRef
        .doc(currentUser!.email)
        .collection('favItems')
        .doc()
        .set({
      'name': widget.product['product-name'],
      'price': widget.product['product-price'],
      'images': widget.product['product-img'],
    });
  }
}
