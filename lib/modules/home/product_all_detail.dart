import 'package:Apehipo/auth/auth_controller.dart';
import 'package:Apehipo/modules/cart/cart_controller.dart';
import 'package:Apehipo/modules/cart/cart_screen.dart';
import 'package:Apehipo/modules/cart/cart_change.dart';
import 'package:Apehipo/modules/home/home_model.dart';
import 'package:Apehipo/modules/product_details/spesifikasi_bottom.dart';
import 'package:Apehipo/modules/product_details/deskripsi_bottom.dart';
import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:Apehipo/widgets/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:Apehipo/screens/profile_screen.dart';
import 'package:Apehipo/widgets/success_confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:Apehipo/widgets/app_button.dart';
import 'package:Apehipo/widgets/app_text.dart';
import 'package:Apehipo/widgets/item_counter_widget.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatefulWidget {
  final HomeModel productItem;
  final String? heroSuffix;

  const ProductDetailScreen(this.productItem, {this.heroSuffix});

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int amount = 1;
  var controller = Get.put(CartController());
  var auth = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartChange>(context);
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Text(
                'Rincian Produk',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              if (auth.box.read("role") == "konsumen")
                Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: InkWell(
                        onTap: () {
                          Get.to(CartScreen());
                        },
                        child: SvgPicture.asset("assets/icons/cart_icon.svg"),
                      ),
                    ),
                    Positioned(
                      right: 0, // Menentukan posisi horizontal
                      top: 0, // Menentukan posisi vertikal
                      child: Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primaryColor, // Warna latar belakang
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
                )
            ],
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
                    if (auth.box.read("role") == "konsumen")
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
                    // Spacer(),
                    Divider(thickness: 1),
                    getProfile(widget.productItem),
                    Divider(thickness: 1),
                    getProductDataRowWidget("Deskripsi",
                        rincian: widget.productItem.deskripsi, key: "products"),
                    Divider(thickness: 1),
                    getProductDataRowWidget("Spesifikasi",
                        customWidget: spesifikasiWidget(),
                        alamat: widget.productItem.alamatPetani,
                        stok: widget.productItem.stok,
                        key: "nutritions"),
                    Divider(thickness: 1),
                    Spacer(),
                    if (auth.box.read("role") == "konsumen")
                      AppButton(
                        label: "Tambah ke Keranjang",
                        onPressed: () async {
                          String result = await controller.tambahData(
                              widget.productItem.kode,
                              widget.productItem.nama,
                              widget.productItem.harga,
                              widget.productItem.foto,
                              widget.productItem.namaPetani,
                              this.amount);
                          if (result == "sukses") {
                            cart.incrementCounter(controller.dataList!.length);
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return SuccessConfirmationDialog(
                                      message:
                                          "Anda berhasil menambahkan produk",
                                      icon: Icons.check_circle_outline);
                                });
                          } else if (result == "gagal") {
                            await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return SuccessConfirmationDialog(
                                      message: "Gagal menambahkan produk",
                                      icon: Icons.close_rounded);
                                });
                          } else if (result == "duplikat") {
                            await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return SuccessConfirmationDialog(
                                      message: "Produk sudah ditambahkan",
                                      icon: Icons.close_rounded);
                                });
                          } else {
                            await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return SuccessConfirmationDialog(
                                      message: "Pesanan harus satu toko/petani",
                                      icon: Icons.close_rounded);
                                });
                          }
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
          widget.productItem.foto,
          width: MediaQuery.of(context).size.width,
          height: 75,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget getProductDataRowWidget(String label,
      {Widget? customWidget,
      String? stok,
      String? rincian,
      String? alamat,
      String? key}) {
    return InkWell(
      onTap: () => {
        if (key == "products")
          {showBottomSheets(context, rincian: rincian, key: "products")}
        else if (key == "nutritions")
          {
            showBottomSheets(context,
                stok: stok, alamat: alamat, key: "nutritions")
          }
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

  void showBottomSheets(context,
      {String? stok, String? rincian, String? alamat, String? key}) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext bc) {
          if (key == "products") {
            return DeskripsiBottom(rincian);
          } else if (key == "nutritions") {
            return SpesifikasiBottom(stok, alamat);
          } else if (key == "review") {}

          return SizedBox.shrink();
        });
  }

  Widget getProfile(HomeModel productItem) {
    return InkWell(
      onTap: () => {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProfileScreen(productItem),
            ))
      },
      child: Row(
        children: [
          CircleAvatar(
            child: ClipOval(
              child: Image.network(
                productItem.fotoPetani,
                fit: BoxFit.cover,
                width: 64,
                height: 64,
              ),
            ),
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
                      productItem.namaPetani,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        // Add other text styles as needed
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        text: productItem.alamatPetani.length <= 30
                            ? productItem.alamatPetani
                            : '${productItem.alamatPetani.substring(0, 30)}...',
                        style: TextStyle(
                          color: Colors
                              .black, // Ganti warna teks "Banjarmasin" dengan warna lain sesuai keinginan Anda
                          fontSize: 14, // Ukuran font "Banjarmasin"
                          fontWeight:
                              FontWeight.normal, // Gaya teks "Banjarmasin"
                          // Add other text styles as needed
                        ),
                      ),
                      overflow: TextOverflow
                          .ellipsis, // Efek elipsis jika teks terlalu panjang
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
