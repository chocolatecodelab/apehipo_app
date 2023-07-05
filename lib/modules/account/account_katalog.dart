import 'package:apehipo_app/modules/account/models/katalog_item.dart';
import 'package:apehipo_app/modules/account/catalog_details.dart';
import 'package:apehipo_app/widgets/theme.dart';
import 'package:flutter/material.dart';
// import 'package:apehipo_app/models/katalog_item.dart';
// import 'package:apehipo_app/screens/product_details/product_details_screen.dart';
import 'package:apehipo_app/widgets/colors.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:apehipo_app/widgets/catalog_item_widget.dart';
import 'package:apehipo_app/widgets/app_button.dart';

class ManageProductsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Katalog',
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
                  spreadRadius: 1,
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
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  padded(subTitle("Produk Anda")),
                  getVerticalItemSlider(penawaranSpesial),
                  getTambahButton("Tambah Produk Baru")
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getTambahButton(String label, {Widget? trailingWidget}) {
    return Container(
      width: 400,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          visualDensity: VisualDensity.compact,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          elevation: 0,
          backgroundColor: AppColors.primaryColor,
          textStyle: TextStyle(
            color: Colors.white,
            fontFamily: gilroyFontFamily,
          ),
          padding: EdgeInsets.symmetric(vertical: 24),
          minimumSize: const Size.fromHeight(50),
        ),
        child: Stack(
          fit: StackFit.passthrough,
          children: <Widget>[
            Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Icon(
                  Icons.add,
                  size: 18,
                  color: Colors.white,
                ),
              ],
            )),
            if (trailingWidget != null)
              Positioned(
                top: 0,
                right: 25,
                child: trailingWidget,
              ),
          ],
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

  Widget getVerticalItemSlider(List<KatalogItem> items) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      height: 530,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 20),
        itemCount: items.length,
        scrollDirection:
            Axis.vertical, // Mengubah scrollDirection menjadi vertical
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              onItemClicked(context, items[index]);
            },
            child: CatalogItemWidget(
              item: items[index],
              heroSuffix: "account_katalog",
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            height: 20, // Mengubah width menjadi height
          );
        },
      ),
    );
  }

  void onItemClicked(BuildContext context, KatalogItem katalogItem) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CatalogDetailsScreen(
                katalogItem,
                heroSuffix: "account_katalog",
              )),
    );
  }

  Widget subTitle(String text) {
    return Row(
      children: [
        Text(
          text,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Spacer(),
        // Text(
        //   "See All",
        //   style: TextStyle(
        //       fontSize: 18,
        //       fontWeight: FontWeight.bold,
        //       color: AppColors.primaryColor),
        // ),
      ],
    );
  }
}
