import 'package:apehipo_app/widgets/app_text.dart';
import 'package:flutter/material.dart';


// class CardWidget extends StatelessWidget {
//   const CardWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // return Container(
//     //   child: GridView.builder(
//     //     padding: const EdgeInsets.all(30),
//     //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//     //       crossAxisCount: 2,
//     //       crossAxisSpacing: 20,
//     //       mainAxisSpacing: 20,
//     //     ),
//     //     itemCount: 2,
//     //     itemBuilder: (context, index) {
//     //       return addWidget();
//     //     },
//     //   ),
//     //   // child: GridView.count(
//     //   //   padding: const EdgeInsets.all(30),
//     //   //   crossAxisSpacing: 20,
//     //   //   mainAxisSpacing: 20,
//     //   //   crossAxisCount: 2,
//     //   //   children: <Widget> [
//     //   //     addWidget(),
//     //   //     addWidget(),
//     //   //     addWidget()
//     //   //   ],
//     //   // ),
//     // );
//   }

//   Widget imageWidget() {
//     return Container(
//       child: Image.asset("assets/images/grocery_images/apple.png"),
//     );
//   }

//   Widget addWidget() {
//     return Container(
//       width: 174,
//             height: 250,
//             decoration: BoxDecoration(
//               border: Border.all(
//                 color: Color(0xffE2E2E2)
//               ),
//               borderRadius: BorderRadius.circular(18)
//             ),
//             child: Padding(padding: const EdgeInsets.symmetric(
//               horizontal: 15,
//               vertical: 15,
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//               Expanded(
//               child: Center(
//                 child: imageWidget(),
//               ),
//               ),
//               SizedBox(height: 20,),
//               AppText(text: "Apple", fontSize: 16, fontWeight: FontWeight.bold,),
//               AppText(
//               text: "75 gr",
//               fontSize: 14,
//               fontWeight: FontWeight.w600,
//               color: Color(0xFF7C7C7C),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Row(
//               children: [
//                 AppText(
//                   text: "\$75000",
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 Spacer(),
//               ],
//             )
//             ],
//             ),
//             ),
//     );
//   }

//   }

import 'package:flutter/material.dart';
import 'package:apehipo_app/widgets/app_text.dart';
import 'package:apehipo_app/modules/home/models/grocery_item.dart';
import 'package:apehipo_app/widgets/colors.dart';

class CardItem extends StatelessWidget {
  CardItem({Key? key, required this.item, this.heroSuffix})
      : super(key: key);

  final GroceryItem item;
  final String? heroSuffix;

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
            Expanded(
              child: Center(
                child: imageWidget(),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            AppText(
              text: item.name,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            AppText(
              text: item.description,
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
                  text: "\$${item.price.toStringAsFixed(2)}",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                Spacer(),
                // addWidget()
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget imageWidget() {
    return Container(
      child: Image.asset(item.imagePath),
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
