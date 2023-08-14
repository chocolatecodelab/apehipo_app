import 'package:apehipo_app/modules/contoh_api/product_model.dart';
import 'package:apehipo_app/modules/home/home_model.dart';
import 'package:apehipo_app/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:apehipo_app/modules/home/models/grocery_item.dart';
import 'package:apehipo_app/modules/product_details/product_details_screen.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String selectedBinaryOption = "";
  bool showBestSeller = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          toolbarHeight: 80,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: () {
              Get.back();
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.share),
              color: Colors.black,
              onPressed: () {
                // Add your share functionality here
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            AssetImage("assets/images/account_image.jpg"),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      "Nazar Gunawan",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text("32",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              )),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Produk",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Text("1000",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              )),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Terjual",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Text("100",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              )),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Pembeli",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: 350,
                    height: 50,
                    child: AppButton(
                      label: "Chat on WhatsApp",
                      onPressed: () => {},
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: double.maxFinite,
                    height: double.maxFinite,
                    child: DefaultTabController(
                      length: 2,
                      child: Column(
                        children: [
                          TabBar(
                            labelColor: Colors.black,
                            unselectedLabelColor: Colors.grey,
                            tabs: [
                              Tab(text: "Best Seller"),
                              Tab(text: "All Products"),
                            ],
                          ),
                          Expanded(
                            child: TabBarView(
                              children: [
                                // Content of the first tab (Places)
                                Container(
                                  child: getItemWidget(exclusiveOffers),
                                ),
                                // Content of the second tab (Inspiration)
                                Container(
                                  child: getItemWidget(demoItems),
                                ),
                                // Content of the third tab (Emotion)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // color: Colors.white,
                  // padding: const EdgeInsets.symmetric(horizontal: 20),
                  // child: Column(
                  //   children: [
                  //     CustomBinaryOption(
                  //     textLeft: "Best `Seller",
                  //     textRight: "All Products",
                  //     onOptionChanged: (bool isBestSeller) {
                  //       setState(() {
                  //         showBestSeller = !isBestSeller;
                  //         print(showBestSeller);
                  //       });

                  //       if (showBestSeller) {
                  //         getItemWidget(demoItems);
                  //       } else {
                  //         getItemWidget(exclusiveOffers);
                  //       }
                  //     },
                  //   ),

                  //   ],
                  // )
                ],
              ),
            ),
          ],
        )));
  }
}

Widget getItemWidget(List<GroceryItem> items) {
  return Container(
      child: GridView.builder(
    physics: NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    padding: const EdgeInsets.all(10),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 20,
      mainAxisSpacing: 20,
    ),
    itemCount: items.length,
    itemBuilder: (context, index) {
      // return GestureDetector(
      //   onTap: () {
      //     onItemClicked(context, items[index]);
      //   },
      //   child: CardItem(
      //     item: items[index],
      //   ),
      // );
    },
  ));
}

void onItemClicked(BuildContext context, HomeModel productItem) {
  Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => ProductDetailsScreen(
              productItem,
              heroSuffix: "home_screen",
            )),
  );
}
