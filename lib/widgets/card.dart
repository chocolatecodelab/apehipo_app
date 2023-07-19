import 'package:apehipo_app/widgets/app_text.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
        padding: const EdgeInsets.all(30),
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        crossAxisCount: 2,
        children: <Widget> [
          addWidget(),
          addWidget(),
          addWidget()
        ],
      ),
    );
  }

  Widget imageWidget() {
    return Container(
      child: Image.asset("assets/images/grocery_images/apple.png"),
    );
  }

  Widget addWidget() {
    return Container(
      width: 174,
            height: 250,
            decoration: BoxDecoration(
              border: Border.all(
                color: Color(0xffE2E2E2)
              ),
              borderRadius: BorderRadius.circular(18)
            ),
            child: Padding(padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 15,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Expanded(
              child: Center(
                child: imageWidget(),
              ),
              ),
              SizedBox(height: 20,),
              AppText(text: "Apple", fontSize: 16, fontWeight: FontWeight.bold,),
              AppText(
              text: "75 gr",
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF7C7C7C),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                AppText(
                  text: "\$75000",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                Spacer(),
              ],
            )
            ],
            ),
            ),
    );
  }

  }