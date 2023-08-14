import 'package:apehipo_app/modules/home/home_model.dart';
import 'package:apehipo_app/modules/product_details/spesifikasi_bottom.dart';
import 'package:apehipo_app/modules/product_details/deskripsi_bottom.dart';
import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:apehipo_app/modules/cart/cart_screen.dart';
import 'package:apehipo_app/modules/product_details/stocks_bottom.dart';
// import 'package:apehipo_app/modules/product_details/product_details_bottom.dart';
import 'package:apehipo_app/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:apehipo_app/widgets/app_button.dart';
import 'package:apehipo_app/widgets/app_text.dart';
import 'package:apehipo_app/widgets/item_counter_widget.dart';

// import '../favourite_toggle_icon_widget.dart';

class DashboardDetailScreen extends StatefulWidget {
  final HomeModel productItem;
  final String? heroSuffix;

  const DashboardDetailScreen(this.productItem, {this.heroSuffix});

  @override
  _DashboardDetailScreenState createState() => _DashboardDetailScreenState();
}

class _DashboardDetailScreenState extends State<DashboardDetailScreen> {
  int amount = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Product Detail',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(4.0),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 0,
                    offset: Offset(0, 0), // Controls the position of the shadow
                  ),
                ],
              ),
            ),
          ),
          iconTheme: IconThemeData(
            color: Color.fromARGB(255, 22, 22, 22),
          ),
        ),
        body: SafeArea(
          child: Container(
              child: Column(children: [
            getImageHeaderWidget(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        widget.productItem.nama,
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      subtitle: AppText(
                        text: widget.productItem.jenis,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff7C7C7C),
                      ),
                      // trailing: FavoriteToggleIcon(),
                    ),
                    Row(
                      children: [
                        ItemCounterWidget(
                          onAmountChanged: (newAmount) {
                            setState(() {
                              amount = newAmount;
                            });
                          },
                        ),
                        Spacer(),
                        Text(
                          "Rp${getTotalPrice().toStringAsFixed(0)}",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                    Spacer(),
                    Divider(thickness: 1),
                    getProfile(),
                    Divider(thickness: 1),
                    getProductDataRowWidget("Deskripsi",
                        rincian: widget.productItem.deskripsi, key: "products"),
                    Divider(thickness: 1),
                    getProductDataRowWidget("Spesifikasi",
                        customWidget: spesifikasiWidget(),
                        stok: widget.productItem.stok,
                        key: "nutritions"),
                    Divider(thickness: 1),
                    // getProductDataRowWidget(
                    //   "Review",
                    //   customWidget: ratingWidget(),
                    // ),
                    Spacer(),
                    AppButton(
                      label: "Add To Basket",
                      onPressed: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CartScreen(),
                            ))
                      },
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ])),
        ));
  }

  Widget getImageHeaderWidget() {
    return Container(
      height: 250,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
        gradient: new LinearGradient(
            colors: [
              const Color(0xFF3366FF).withOpacity(0.1),
              const Color(0xFF3366FF).withOpacity(0.09),
            ],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(0.0, 1.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10),
        ),
        child: Image.network(
          "https://asset.kompas.com/crops/fIaNWDAjRZ8OzH-6PTSsBisOyA0=/87x0:759x448/750x500/data/photo/2023/03/05/64049a48c2ac7.jpg",
          width: MediaQuery.of(context).size.width,
          height: 75,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget getProductDataRowWidget(String label,
      {Widget? customWidget, String? stok, String? rincian, String? key}) {
    return InkWell(
      onTap: () => {
        if (key == "products")
          {showBottomSheets(context, rincian: rincian, key: "products")}
        else if (key == "nutritions")
          {showBottomSheets(context, stok: stok, key: "nutritions")}
        else if (key == "reviews")
          {showBottomSheets(context, key: "reviews")}
        else
          {}
      },
      child: Container(
        margin: EdgeInsets.only(
          top: 20,
          bottom: 20,
        ),
        child: Row(
          children: [
            AppText(text: label, fontWeight: FontWeight.w600, fontSize: 16),
            Spacer(),
            if (customWidget != null) ...[
              customWidget,
              SizedBox(
                width: 20,
              )
            ],
            Icon(
              Icons.arrow_forward_ios,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  void showBottomSheets(context, {String? stok, String? rincian, String? key}) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext bc) {
          if (key == "products") {
            return DeskripsiBottom(rincian);
          } else if (key == "nutritions") {
            return SpesifikasiBottom(stok);
          } else if (key == "review") {}

          return SizedBox.shrink();
        });
  }

  // Widget getProductDetails(context) {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.end,
  //     children: [
  //       IconButton(
  //       onPressed: () => {
  //         showBottomSheets(context)
  //       },
  //       icon: Icon(Icons.arrow_forward_ios),
  //     ),
  //     ],
  //   );
  // }

  Widget getProfile() {
    return InkWell(
      onTap: () => {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProfileScreen(),
            ))
      },
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/account_image.jpg"))),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Petani Kode",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        // Add other text styles as needed
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        text: "Banjarmasin",
                        style: TextStyle(
                          color: Colors
                              .black, // Ganti warna teks "Banjarmasin" dengan warna lain sesuai keinginan Anda
                          fontSize: 14, // Ukuran font "Banjarmasin"
                          fontWeight:
                              FontWeight.normal, // Gaya teks "Banjarmasin"
                          // Add other text styles as needed
                        ),
                      ),
                    ),
                  ],
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget spesifikasiWidget() {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Color(0xffEBEBEB),
        borderRadius: BorderRadius.circular(5),
      ),
      child: AppText(
        text: "100",
        fontWeight: FontWeight.w600,
        fontSize: 12,
        color: Color(0xff7C7C7C),
      ),
    );
  }

  // Widget ratingWidget() {
  //   Widget starIcon() {
  //     return Icon(
  //       Icons.star,
  //       color: Color(0xffF3603F),
  //       size: 20,
  //     );
  //   }

  //   return Row(
  //     children: [
  //       starIcon(),
  //       starIcon(),
  //       starIcon(),
  //       starIcon(),
  //       starIcon(),
  //     ],
  //   );
  // }

  int getTotalPrice() {
    int harga = int.parse(widget.productItem.harga);
    return amount * harga;
  }
}

class CarouselImage extends StatefulWidget {
  const CarouselImage({super.key});

  @override
  State<CarouselImage> createState() => _CarouselImageState();
}

class _CarouselImageState extends State<CarouselImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 250,
            width: double.infinity,
            child: AnotherCarousel(
              images: const [
                AssetImage("assets/images/role_consumer.jpg"),
                AssetImage("assets/images/role_hydroponic_farmer.jpg"),
              ],
              dotSize: 6,
              dotBgColor: Colors.transparent,
              borderRadius: true,
            ),
          )
        ],
      ),
    );
  }
}
