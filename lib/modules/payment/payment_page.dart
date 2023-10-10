import 'package:apehipo_app/modules/payment/payment_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';

class PaymentPage extends StatelessWidget {
  final String? noRekening;

  const PaymentPage(this.noRekening);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PaymentCard(
              name: "John Doe",
              accountNumber: "1234 5678 9012 3456",
              paymentIcon: Icons.credit_card,
            ),
            SizedBox(height: 20),
            PaymentCard(
              name: "Jane Smith",
              accountNumber: "9876 5432 1098 7654",
              paymentIcon: Icons.account_balance,
            ),
          ],
        ),
      ),
    );
  }
}
