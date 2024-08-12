import '../../../widgets/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SearchBarKelolaKebun extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onTap;
  SearchBarKelolaKebun({required this.controller, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.70,
          margin: EdgeInsets.only(left: 25),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.all(16),
              hintText: "Cari...",
              hintStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF7C7C7C),
              ),
            ),
          ),
        ),
        Container(
          height: 50,
          width: 50,
          margin: EdgeInsets.only(right: 25),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
          child: Center(
            child: IconButton( onPressed: onTap, icon: Icon(Icons.search, color: AppColors.primaryColor, size: 30,),
              // child: Icon(
              //   Icons.search,
              //   color: AppColors.primaryColor,
              //   size: 30,
              ),
            ),
          ),
      ],
    );
  }
}
