import 'package:apehipo_app/modules/cart/checkout_bottom_sheet.dart';
import 'package:apehipo_app/widgets/app_button.dart';
import 'package:apehipo_app/widgets/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentCard extends StatefulWidget {
  final String name;
  final String accountNumber;
  final IconData paymentIcon;

  PaymentCard({
    required this.name,
    required this.accountNumber,
    required this.paymentIcon,
  });

  @override
  _PaymentCardState createState() => _PaymentCardState();
}

class _PaymentCardState extends State<PaymentCard> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: InkWell(
        onTap: () {
          setState(() {
            isPressed = !isPressed;
          });
        },
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          elevation: isPressed ? 0.0 : 4.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                color: isPressed ? AppColors.darkGrey : AppColors.primaryColor,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Icon(
                        widget.paymentIcon,
                        size: 32,
                        color: Colors.white,
                      ),
                      SizedBox(width: 16.0),
                      Text(
                        widget.name,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 8.0),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "Nomor Rekening: ${widget.accountNumber}",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: isPressed ? AppColors.darkGrey : Colors.grey,
                  ),
                ),
              ),
              if (isPressed)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: AppButton(
                    label: "Apply",
                    onPressed: () {
                      Get.back();
                    },
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
