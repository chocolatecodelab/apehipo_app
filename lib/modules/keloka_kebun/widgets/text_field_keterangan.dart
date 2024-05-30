import 'package:Apehipo/widgets/colors.dart';
import 'package:flutter/material.dart';

class TextFieldKeterangan extends StatelessWidget {
  final TextEditingController controller;
  TextFieldKeterangan({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120, // supaya container tidak memanjang
      margin: EdgeInsets.symmetric(
        horizontal: 25,
      ),
      child: TextField(
        controller: controller,
        minLines: 5,
        maxLines: null,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primaryColor),
            borderRadius: BorderRadius.circular(15),
          ),
          contentPadding: EdgeInsets.all(16),
          labelText: "keterangan",
          labelStyle: TextStyle(
            color: Color(0xFFC1C1C1),
          ),
          alignLabelWithHint: true,
          floatingLabelStyle: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
