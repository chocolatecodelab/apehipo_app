import 'package:apehipo_app/modules/home/models/grocery_item.dart';
import 'package:apehipo_app/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class CustomBinaryOption extends StatefulWidget {
  CustomBinaryOption({
    Key? key,
    this.textLeft = "Left",
    this.textRight = "Right",
    required this.onOptionChanged,
  }) : super(key: key);
  String textLeft;
  String textRight;
  final Function(bool) onOptionChanged;

  @override
  State<CustomBinaryOption> createState() => _CustomBinaryOptionState();
}

class _CustomBinaryOptionState extends State<CustomBinaryOption> {
  bool lr = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        color: Colors.white,
        height: 50,
        child: Row(
          children: [
            Expanded(
              child: InkWell(
              onTap: () {
                setState(() {
                  lr = false;
                });
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    widget.textLeft,
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: lr == false ? Colors.green : Colors.grey),
                  ),
                  Container(
                    height: lr == false ? 3 : 1,
                    color: lr == false ? Colors.green : Colors.grey,
                  ),
                ],
              ),
            )),
            Expanded(
              child: InkWell(
              onTap: () {
                setState(() {
                  lr = true;
                });
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    widget.textRight,
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: lr == true ? Colors.green : Colors.grey),
                  ),
                  Container(
                    height: lr == true ? 3 : 1,
                    color: lr == true ? Colors.green : Colors.grey,
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}