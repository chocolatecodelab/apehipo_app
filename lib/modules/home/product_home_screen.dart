import 'package:apehipo_app/modules/cart/cart_screen.dart';
import 'package:apehipo_app/modules/home/home_controller.dart';
import 'package:apehipo_app/modules/home/product_all_detail.dart';
import 'package:apehipo_app/modules/home/home_model.dart';
import 'package:apehipo_app/modules/notification/notification_screen.dart';
import 'package:apehipo_app/widgets/card_item_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:apehipo_app/widgets/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:apehipo_app/widgets/search_bar_widget.dart';
import 'package:get/get.dart';
import 'package:apehipo_app/modules/home/klasifikasi_screen.dart';
import 'home_banner_widget.dart';

class ProductHomeScreen extends StatefulWidget {
  @override
  State<ProductHomeScreen> createState() => _ProductHomeScreenState();
}

class _ProductHomeScreenState extends State<ProductHomeScreen> {
  @override
  var controller = Get.put(HomeController());

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            child: Obx(
          () => controller.isLoading.value
              ? Center(child: CircularProgressIndicator())
              : controller.dataListEksklusif!.isEmpty
                  ? Center(child: Text("Tidak ada data"))
                  : SingleChildScrollView(
                      child: Center(
                        child: Column(
                          children: [
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8),
                                  child: InkWell(
                                    onTap: () {
                                      // Handle the tap event for the first SVG icon
                                      // Add your desired action here
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                NotificationScreen(),
                                          ));
                                    },
                                    child: SvgPicture.asset(
                                        "assets/icons/account_icons/notification_icon.svg"),
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => CartScreen(),
                                          ));
                                    },
                                    child: SvgPicture.asset(
                                        "assets/icons/cart_icon.svg"),
                                  ),
                                ),
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
                            padded(HomeBanner()),
                            SizedBox(
                              height: 25,
                            ),
                            padded(subTitle(context, "Penjualan Ekslusif",
                                key: "penjualan eksklusif",
                                items: controller.dataListEksklusif)),
                            getHorizontalItemSlider(
                                controller.dataListEksklusif!,
                                "penjualan eksklusif"),
                            SizedBox(
                              height: 15,
                            ),
                            padded(subTitle(context, "Penjualan Terbaik",
                                key: "penjualan terbaik",
                                items: controller.dataListTerbaik)),
                            getHorizontalItemSlider(controller.dataListTerbaik!,
                                "penjualan terbaik"),
                            SizedBox(
                              height: 15,
                            ),
                            padded(subTitle(context, "Sedang Laris",
                                key: "sedang laris",
                                items: controller.dataListLaris)),
                            getHorizontalItemSlider(
                                controller.dataListLaris!, "sedang laris"),
                            SizedBox(
                              height: 15,
                            ),
                            Container(),
                          ],
                        ),
                      ),
                    ),
        )),
      ),
    );
  }

  Widget padded(Widget widget) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: widget,
    );
  }

  Widget getHorizontalItemSlider(List<HomeModel> items, String klasifikasi) {
    List<HomeModel> filteredItems =
        items.where((item) => item.klasifikasi == klasifikasi).toList();
    filteredItems = filteredItems.take(3).toList();
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      height: 250,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 20),
        itemCount: filteredItems.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, i) {
          return GestureDetector(
            onTap: () {
              onItemClicked(context, filteredItems[i]);
            },
            child: CardItemDashboard(
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

  void onItemClicked(BuildContext context, HomeModel homeItem) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => DashboardDetailScreen(
                homeItem,
                heroSuffix: "home_screen",
              )),
    );
  }

  Widget subTitle(BuildContext context, String text,
      {String? key, List<HomeModel>? items}) {
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
          onTap: () => {Get.to(BestSellingOffer(key, text, items))},
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
