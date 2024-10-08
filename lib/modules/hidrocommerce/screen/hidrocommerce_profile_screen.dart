import 'package:Apehipo/modules/hidrocommerce/screen/hidrocommerce_detail_produk_screen.dart';

import '../../catalog/controller/catalog_controller.dart';
import 'package:Apehipo/modules/hidrocommerce/controller/hidrocommerce_controller.dart';
import 'package:Apehipo/modules/hidrocommerce/model/hidrocommerce_model.dart';
import 'package:Apehipo/widgets/app_button.dart';
import 'package:Apehipo/widgets/app_text.dart';
import 'package:Apehipo/modules/hidrocommerce/screen/widget/card_klasifikasi_widget.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:get/get.dart';

class HidrocommerceProfileScreen extends StatefulWidget {
  final HidrocommerceModel hidrocommerceModel;

  const HidrocommerceProfileScreen(this.hidrocommerceModel, {super.key});

  @override
  State<HidrocommerceProfileScreen> createState() =>
      _HidrocommerceProfileScreenState();
}

class _HidrocommerceProfileScreenState
    extends State<HidrocommerceProfileScreen> {
  String selectedBinaryOption = "";
  bool showBestSeller = true;
  var katalog = Get.put(CatalogController());
  var home = Get.put(HidrocommerceController());

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
        .where((item) => item.idUser == widget.hidrocommerceModel.idUser)
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
                          radius: 45,
                          child: ClipOval(
                            child: Image.network(
                              widget.hidrocommerceModel.fotoPetani,
                              fit: BoxFit.cover,
                              width: 90,
                              height: 90,
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(20),
                    //   child: Text(
                    //     widget.hidrocommerceModel.namaPetani,
                    //     style: TextStyle(
                    //       fontSize: 25,
                    //       fontWeight: FontWeight.bold,
                    //     ),
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Center(
                          child: Text(
                            widget.hidrocommerceModel.namaPetani,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ),
                        subtitle: Center(
                          child: AppText(
                            text: widget.hidrocommerceModel.alamatPetani,
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
                              height: 5,
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
                      height: 10,
                    ),
                    Container(
                      width: 350,
                      height: 50,
                      child: AppButton(
                        label: "Chat on WhatsApp",
                        onPressed: () => {
                          _launchWhatsApp(
                              widget.hidrocommerceModel.noTelpon.toString(),
                              "Halo Petani, saya ingin bertanya mengenai produk Hidroponik Anda")
                        },
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 350,
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
                                        widget.hidrocommerceModel.idUser),
                                  ),
                                  // Content of the second tab (Inspiration)
                                  Container(
                                    child: getItemWidget(home.dataList!,
                                        widget.hidrocommerceModel.idUser),
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

Widget getItemWidget(List<HidrocommerceModel> items, String idUser) {
  List<HidrocommerceModel> filteredItems =
      items.where((item) => item.idUser == idUser).toList();
  return Container(
      // margin: EdgeInsets.only(bottom: 12),
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
        child: CardKlasifikasiWidget(
          item: filteredItems[index],
          context: context,
        ),
      );
    },
  ));
}

void onItemClicked(
    BuildContext context, HidrocommerceModel hidrocommerceModel) {
  Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => HidrocommerceDetailProdukScreen(
              hidrocommerceModel,
              heroSuffix: "home_screen",
            )),
  );
}
