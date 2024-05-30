import 'package:Apehipo/modules/auth/controller/auth_controller.dart';
import 'package:Apehipo/modules/cart/screen/cart_screen.dart';
import 'package:Apehipo/modules/cart/screen/cart_change.dart';
import 'package:Apehipo/modules/hidrocommerce/controller/hidrocommerce_controller.dart';
import 'package:Apehipo/modules/hidrocommerce/model/hidrocommerce_model.dart';
import 'package:Apehipo/modules/hidrocommerce/screen/hidrocommerce_detail_produk_screen.dart';
import 'package:Apehipo/modules/notification/notification_change.dart';
import 'package:Apehipo/modules/notification/controller/notification_controller.dart';
import 'package:Apehipo/modules/notification/model/notif_model.dart';
import 'package:Apehipo/modules/notification/screen/notification_screen.dart';
import 'package:Apehipo/modules/hidrocommerce/screen/widget/card_klasifikasi_widget.dart';
import 'package:flutter/material.dart';
import 'package:Apehipo/widgets/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:Apehipo/modules/hidrocommerce/screen/widget/search_bar_widget.dart';
import 'package:get/get.dart';
import 'package:Apehipo/modules/hidrocommerce/screen/hidrocommerce_klasifikasi_screen.dart';
import 'package:provider/provider.dart';
import 'widget/banner_widget.dart';

class HidrocommerceScreen extends StatefulWidget {
  @override
  State<HidrocommerceScreen> createState() => _HidrocommerceScreenState();
}

class _HidrocommerceScreenState extends State<HidrocommerceScreen> {
  GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();
  var controller = Get.put(HidrocommerceController());
  var auth = Get.put(AuthController());

  @override
  void initState() {
    super.initState();
  }

  Future<void> refreshData() async {
    await controller.refresh(); // Panggil metode refresh dari controller
    // Untuk menghentikan indikator refresh, panggil setState
    if (mounted) {
      setState(() {
        // Ini akan menghentikan indikator refresh
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var notifController = Get.put(NotificationController());
    final cart = Provider.of<CartChange>(context);
    final notif = Provider.of<NotificationChange>(context);
    List<NotifModel> notifTidakTerbaca =
        notifController.dataList!.where((x) => x.status == "false").toList();
    notif.incrementCounter(notifTidakTerbaca.length);
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          key: _refreshKey,
          onRefresh: () => refreshData(),
          child: Container(
              child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Stack(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: InkWell(
                              onTap: () {
                                Get.to(NotificationScreen());
                              },
                              child: SvgPicture.asset(
                                  "assets/icons/account_icons/notification_icon.svg"),
                            ),
                          ),
                          Positioned(
                            right: 0, // Menentukan posisi horizontal
                            top: 0, // Menentukan posisi vertikal
                            child: Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors
                                    .primaryColor, // Warna latar belakang
                              ),
                              child: Text(
                                notif.itemCount.toString(),
                                style: TextStyle(
                                  color: Colors.white, // Warna teks
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      if (auth.box.read("role") == "konsumen")
                        Stack(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: InkWell(
                                onTap: () {
                                  Get.to(CartScreen());
                                },
                                child: SvgPicture.asset(
                                    "assets/icons/cart_icon.svg"),
                              ),
                            ),
                            Positioned(
                              right: 0, // Menentukan posisi horizontal
                              top: 0, // Menentukan posisi vertikal
                              child: Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors
                                      .primaryColor, // Warna latar belakang
                                ),
                                child: Text(
                                  cart.itemCount.toString(),
                                  style: TextStyle(
                                    color: Colors.white, // Warna teks
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      SizedBox(
                        width: 20,
                      )
                    ],
                  ),
                  // SvgPicture.asset("assets/icons/app_icon_color.svg"),
                  SizedBox(
                    height: 5,
                  ),
                  // padded(locationWidget()),
                  SizedBox(
                    height: 15,
                  ),
                  padded(SearchBarWidget()),
                  SizedBox(
                    height: 25,
                  ),
                  padded(HidrocommerceBanner()),
                  SizedBox(
                    height: 25,
                  ),
                  Obx(() => controller.isLoading.value
                      ? Column(
                          children: [
                            SizedBox(
                              height: 200,
                            ),
                            Center(
                                child: CircularProgressIndicator(
                              color: AppColors.primaryColor,
                            )),
                          ],
                        )
                      : controller.dataListSayuran!.isEmpty
                          ? Column(
                              children: [
                                SizedBox(
                                  height: 200,
                                ),
                                Center(child: Text("Tidak ada data")),
                              ],
                            )
                          : Column(
                              children: [
                                padded(subTitle(context, "Sayur-sayuran",
                                    key: "sayur",
                                    items: controller.dataListSayuran)),
                                getItemKlasifikasi(
                                    controller.dataListSayuran!, "Sayuran"),
                                SizedBox(
                                  height: 15,
                                ),
                                padded(subTitle(context, "Buah-buahan",
                                    key: "buah",
                                    items: controller.dataListBuah)),
                                getItemKlasifikasi(
                                    controller.dataListBuah!, "Buah"),
                              ],
                            )),
                  SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(),
                ],
              ),
            ),
          )),
        ),
      ),
    );
  }

  Widget padded(Widget widget) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: widget,
    );
  }

  Widget getItemKlasifikasi(List<HidrocommerceModel> items, String jenis) {
    items.sort((a, b) {
      // Mengambil angka dari idOrder menggunakan ekstraksi substring
      int aOrderNumber = int.parse(
          a.kode.substring(1)); // Mengabaikan karakter pertama (biasanya 'O')
      int bOrderNumber = int.parse(b.kode.substring(1));

      // Membandingkan angka-angka tersebut
      return bOrderNumber.compareTo(aOrderNumber);
    });
    List<HidrocommerceModel> filteredItems =
        items.where((item) => item.jenis == jenis).toList();
    filteredItems = filteredItems.take(3).toList();
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      height: 240,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 20),
        itemCount: filteredItems.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, i) {
          return GestureDetector(
            onTap: () {
              onItemClicked(context, filteredItems[i]);
            },
            child: CardKlasifikasiWidget(
              item: filteredItems[i],
              heroSuffix: "home_screen",
              context: context,
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            width: 20,
          );
        },
      ),
    );
  }

  void onItemClicked(BuildContext context, HidrocommerceModel homeItem) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => HidrocommerceDetailProdukScreen(
                homeItem,
                heroSuffix: "home_screen",
              )),
    );
  }

  Widget subTitle(BuildContext context, String text,
      {String? key, List<HidrocommerceModel>? items}) {
    return Row(
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Spacer(),
        GestureDetector(
          onTap: () =>
              {Get.to(HidrocommerceKlasifikasiScreen(key, text, items))},
          child: Text("See All",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor)),
        )
      ],
    );
  }

  Widget locationWidget() {
    String locationIconPath = "assets/icons/location_icon.svg";
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          locationIconPath,
        ),
        SizedBox(
          width: 8,
        ),
        Text(
          "Banjarbaru, Kalimantan Selatan",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
