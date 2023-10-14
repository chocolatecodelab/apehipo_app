import 'package:Apehipo/modules/home/home_model.dart';
import 'package:Apehipo/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:Apehipo/widgets/colors.dart';

class CardItem extends StatelessWidget {
  CardItem(
      {Key? key, required this.item, this.heroSuffix, required this.context})
      : super(key: key);

  final HomeModel item;
  final String? heroSuffix;

  final BuildContext context;
  final double width = 160;
  final double height = 274;
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
          height: 65,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget addWidget() {
    return Container(
      height: 25,
      width: 25,
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
