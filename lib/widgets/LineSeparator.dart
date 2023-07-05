import 'package:flutter/material.dart';

class LineSeparator extends StatelessWidget {
  final double height;
  final Color color;

  const LineSeparator({
    Key? key,
    this.height = 1.0,
    this.color = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      color: color,
    );
  }
}
