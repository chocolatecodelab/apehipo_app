import 'package:apehipo_app/modules/contoh_api/product_model.dart';
import 'package:apehipo_app/modules/home/models/dashboard_model.dart';
import 'package:apehipo_app/widgets/app_text.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:apehipo_app/widgets/app_text.dart';
import 'package:apehipo_app/widgets/colors.dart';

class CardItemDashboard extends StatelessWidget {
  CardItemDashboard(
      {Key? key, required this.item, this.heroSuffix, required this.context})
      : super(key: key);

  final DashboardModel item;
  final String? heroSuffix;

  final BuildContext context;
  final double width = 174;
  final double height = 250;
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
              child: imageWidget(),
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

  Widget imageWidget() {
    return Container(
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
