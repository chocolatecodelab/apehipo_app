import 'package:apehipo_app/modules/cart/cart_screen.dart';
import 'package:apehipo_app/modules/home/offer/exclusive_screen.dart';
import 'package:apehipo_app/modules/home/offer/groceries_screen.dart';
import 'package:apehipo_app/modules/notification/notification_screen.dart';
import 'package:apehipo_app/modules/product/product_model.dart';
import 'package:flutter/material.dart';
import 'package:apehipo_app/modules/home/models/grocery_item.dart';
import 'package:apehipo_app/modules/product_details/product_details_screen.dart';
import 'package:apehipo_app/widgets/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:apehipo_app/widgets/grocery_item_card_widget.dart';
import 'package:apehipo_app/widgets/search_bar_widget.dart';
import 'package:get/get.dart';
import 'package:apehipo_app/modules/home/offer/best_selling_screen.dart';

import 'grocery_featured_Item_widget.dart';
import 'home_banner_widget.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
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
                                  builder: (context) => NotificationScreen(),
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
                          child: SvgPicture.asset("assets/icons/cart_icon.svg"),
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
                  padded(
                      subTitle(context, "Exclusive Order", key: "exclusive")),
                  getHorizontalItemSlider(exclusiveOffers),
                  SizedBox(
                    height: 15,
                  ),
                  padded(
                      subTitle(context, "Best Selling", key: "best_selling")),
                  getHorizontalItemSlider(bestSelling),
                  SizedBox(
                    height: 15,
                  ),
                  padded(subTitle(context, "Groceries", key: "groceries")),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 105,
                    child: ListView(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.horizontal,
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        GroceryFeaturedCard(
                          groceryFeaturedItems[0],
                          color: Color(0xffF8A44C),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        GroceryFeaturedCard(
                          groceryFeaturedItems[1],
                          color: AppColors.primaryColor,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  getHorizontalItemSlider(groceries),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          ),
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

  Widget getHorizontalItemSlider(List<GroceryItem> items) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      height: 250,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 20),
        itemCount: items.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          // return GestureDetector(
          //   onTap: () {
          //     onItemClicked(context, items[index]);
          //   },
          //   child: GroceryItemCardWidget(
          //     item: items[index],
          //     heroSuffix: "home_screen",
          //   ),
          // );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            width: 20,
          );
        },
      ),
    );
  }

  void onItemClicked(BuildContext context, ProductModel productItem) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ProductDetailsScreen(
                productItem,
                heroSuffix: "home_screen",
              )),
    );
  }

  Widget subTitle(BuildContext context, String text, {String? key}) {
    return Row(
      children: [
        Text(
          text,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Spacer(),
        GestureDetector(
          onTap: () => {
            if (key == "best_selling")
              {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BestSellingOffer()),
                )
              }
            else if (key == "exclusive")
              {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ExclusiveOffer()),
                )
              }
            else if (key == "groceries")
              {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GroceriesOffer()),
                )
              }
            else
              {}
          },
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
