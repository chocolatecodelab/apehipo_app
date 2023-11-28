import 'package:Apehipo/modules/home/home_model.dart';
import 'package:Apehipo/widgets/LineSeparator.dart';
import 'package:Apehipo/widgets/app_text.dart';
import 'package:flutter/material.dart';

import 'package:Apehipo/widgets/colors.dart';

class CardItemDashboard extends StatelessWidget {
  CardItemDashboard(
      {Key? key, required this.item, this.heroSuffix, required this.context})
      : super(key: key);

  final HomeModel item;
  final String? heroSuffix;

  final BuildContext context;
  final double width = 174;
  final double height = 260;
  final Color borderColor = Color(0xffE2E2E2);
  final double borderRadius = 18;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor,
        ),
        borderRadius: BorderRadius.circular(
          borderRadius,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: imageWidget(item.foto),
            ),
            SizedBox(
              height: 10,
            ),
            AppText(
              text: item.nama,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            AppText(
              text: item.jenis,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF7C7C7C),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                AppText(
                  text: "Rp${item.harga}",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                Spacer(),
                addWidget()
              ],
            ),
            SizedBox(
              height: 10,
            ),
            LineSeparator(
              height: 1,
              color: const Color.fromARGB(255, 207, 207, 207),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Icon(
                  Icons.home_filled,
                  size: 15,
                ),
                SizedBox(
                  width: 5,
                ),
                RichText(
                  text: TextSpan(
                    text: item.alamatPetani.length <= 15
                        ? item.alamatPetani
                        : '${item.alamatPetani.substring(0, 15)}...',
                    style: TextStyle(
                      color: Colors
                          .black, // Ganti warna teks "Banjarmasin" dengan warna lain sesuai keinginan Anda
                      fontSize: 14, // Ukuran font "Banjarmasin"
                      fontWeight: FontWeight.normal, // Gaya teks "Banjarmasin"
                      // Add other text styles as needed
                    ),
                  ),
                  overflow: TextOverflow
                      .ellipsis, // Efek elipsis jika teks terlalu panjang
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget imageWidget(String foto) {
    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10),
        ),
        child: Image.network(
          foto,
          width: MediaQuery.of(context).size.width,
          height: 75,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget addWidget() {
    return Container(
      height: 45,
      width: 45,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17),
          color: AppColors.primaryColor),
      child: Center(
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 25,
        ),
      ),
    );
  }
}
