import 'package:Apehipo/modules/catalog/catalog_controller.dart';
import 'package:Apehipo/modules/home/home_controller.dart';
import 'package:Apehipo/modules/home/home_model.dart';
import 'package:Apehipo/widgets/app_button.dart';
import 'package:Apehipo/widgets/app_text.dart';
import 'package:Apehipo/widgets/card_item_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:Apehipo/modules/product_details/product_details_screen.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  final HomeModel productItem;

  const ProfileScreen(this.productItem, {super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String selectedBinaryOption = "";
  bool showBestSeller = true;
  var katalog = Get.put(CatalogController());
  var home = Get.put(HomeController());

  Future<void> _launchWhatsApp(String phoneNumber, String message) async {
    if (phoneNumber.startsWith('0')) {
      // Mengganti "0" di awal nomor dengan "62"
      phoneNumber = '62${phoneNumber.substring(1)}';
    }
    final encodedMessage =
        Uri.encodeComponent(message); // Mengekodekan pesan dengan benar

    final url = 'https://wa.me/$phoneNumber/?text=$encodedMessage';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Tidak dapat membuka WhatsApp';
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int jumlahItem = home.dataList!
        .where((item) => item.idUser == widget.productItem.idUser)
        .length;
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
        body: SafeArea(
          child: SingleChildScrollView(
              child: Column(
            children: [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        CircleAvatar(
                          radius: 64,
                          child: ClipOval(
                            child: Image.network(
                              widget.productItem.fotoPetani,
                              fit: BoxFit.cover,
                              width: 128,
                              height: 128,
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(20),
                    //   child: Text(
                    //     widget.productItem.namaPetani,
                    //     style: TextStyle(
                    //       fontSize: 25,
                    //       fontWeight: FontWeight.bold,
                    //     ),
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Center(
                          child: Text(
                            widget.productItem.namaPetani,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ),
                        subtitle: Center(
                          child: AppText(
                            text: widget.productItem.alamatPetani,
                            textAlign: TextAlign.center,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff7C7C7C),
                          ),
                        ),
                        // trailing: FavoriteToggleIcon(),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text(jumlahItem.toString(),
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
                        // Column(
                        //   children: [
                        //     Text("1000",
                        //         style: TextStyle(
                        //           fontSize: 20,
                        //           fontWeight: FontWeight.bold,
                        //         )),
                        //     const SizedBox(
                        //       height: 15,
                        //     ),
                        //     Text(
                        //       "Terjual",
                        //       style: TextStyle(
                        //         fontSize: 15,
                        //         fontWeight: FontWeight.w300,
                        //       ),
                        //     )
                        //   ],
                        // ),
                        // Column(
                        //   children: [
                        //     Text("100",
                        //         style: TextStyle(
                        //           fontSize: 20,
                        //           fontWeight: FontWeight.bold,
                        //         )),
                        //     const SizedBox(
                        //       height: 15,
                        //     ),
                        //     Text(
                        //       "Pembeli",
                        //       style: TextStyle(
                        //         fontSize: 15,
                        //         fontWeight: FontWeight.w300,
                        //       ),
                        //     )
                        //   ],
                        // ),
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
                        onPressed: () => {
                          _launchWhatsApp(
                              widget.productItem.noTelpon.toString(),
                              "Halo Petani, saya ingin bertanya mengenai produk Hidroponik Anda")
                        },
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 300,
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
                                    child: getItemWidget(home.dataList!,
                                        widget.productItem.idUser),
                                  ),
                                  // Content of the second tab (Inspiration)
                                  Container(
                                    child: getItemWidget(home.dataList!,
                                        widget.productItem.idUser),
                                  ),
                                  // Content of the third tab (Emotion)
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
        ));
  }
}

Widget getItemWidget(List<HomeModel> items, String idUser) {
  List<HomeModel> filteredItems =
      items.where((item) => item.idUser == idUser).toList();
  return Container(
      child: GridView.builder(
    padding: const EdgeInsets.all(10),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      mainAxisExtent: 245,
      crossAxisSpacing: 20,
      mainAxisSpacing: 20,
    ),
    itemCount: filteredItems.length,
    itemBuilder: (context, index) {
      return GestureDetector(
        onTap: () {
          onItemClicked(context, filteredItems[index]);
        },
        child: CardItemDashboard(
          item: filteredItems[index],
          context: context,
        ),
      );
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
