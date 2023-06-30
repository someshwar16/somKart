import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
// import 'package:som_kart/Hometabs/CatogeryCard.dart';
// import 'package:som_kart/Hometabs/DiscountCard.dart';
// import 'package:som_kart/Hometabs/SearchBar1.dart';
import 'package:som_kart/const/AppColor.dart';
import 'package:som_kart/screens/product_detail_screen.dart';
import 'package:som_kart/screens/search_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchController = TextEditingController();
  List<String> carsouelImages = [];
  List products = [];
  var dotPosition = 0;
  var firestoreInsatnce = FirebaseFirestore.instance;
  fetchCarouselImages() async {
    QuerySnapshot qn =
        await firestoreInsatnce.collection("carousel-slider").get();

    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        carsouelImages.add(qn.docs[i]['img']);
      }
    });
    return qn.docs;
  }

  fetchProducts() async {
    QuerySnapshot qn = await firestoreInsatnce.collection("products").get();

    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        products.add({
          'product-name': qn.docs[i]['product-name'],
          'product-price': qn.docs[i]['product-price'],
          'product-img': qn.docs[i]['product-img'],
          'product-description': qn.docs[i]['product-description'],
        });
      }
    });
    return qn.docs;
  }

  @override
  void initState() {
    fetchCarouselImages();
    fetchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.loginPage,
        automaticallyImplyLeading: false,
        title: const Text(
          'Som Kart',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: Icon(
          Icons.shopping_cart,
          color: AppColors.energy_yellow,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(right: 10.0, top: 10.0),
          child: Container(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 60.h,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 10.0),
                          child: TextFormField(
                            readOnly: true,
                            onTap: () {
                              Get.to(() => Search());
                            },
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.r),
                                borderSide: BorderSide(
                                  color: Colors.grey[200]!,
                                ),
                              ),
                              hintText: 'Search',
                              hintStyle: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.r),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Colors.grey[200],
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        print('object');
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          //color: AppColors.energy_yellow,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        height: 60.h,
                        width: 30.h,
                        child: const Center(
                          child: Icon(
                            Icons.search,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                AspectRatio(
                  aspectRatio: 3.5,
                  child: CarouselSlider(
                    items: carsouelImages
                        .map(
                          (item) => Container(
                            padding:
                                const EdgeInsets.only(left: 3.0, right: 3.0),
                            decoration: BoxDecoration(
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
                SizedBox(
                  height: 10.h,
                ),
                DotsIndicator(
                  dotsCount: carsouelImages.isEmpty ? 1 : carsouelImages.length,
                  position: dotPosition,
                  decorator: DotsDecorator(
                    activeColor: AppColors.loginPage,
                    color: AppColors.loginPage.withOpacity(0.5),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Expanded(
                  child: GridView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: products.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, childAspectRatio: 1.0),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => Get.to(
                            ProductDetail(
                              product: products[index],
                            ),
                          ),
                          child: Card(
                            elevation: 3,
                            child: Column(
                              children: [
                                AspectRatio(
                                  aspectRatio: 2,
                                  child: Image.network(
                                      products[index]['product-img'][0]),
                                ),
                                Text(products[index]['product-name']),
                                Text(products[index]['product-price']
                                    .toString()),
                              ],
                            ),
                          ),
                        );
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
