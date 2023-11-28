import 'package:Apehipo/modules/home/home_controller.dart';
import 'package:get/get.dart';

import '../modules/home/card_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SearchBarWidgets extends StatefulWidget {
  @override
  _SearchBarWidgetState createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidgets> {
  final String searchIcon = "../assets/icons/search_icon.svg";
  var homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    homeController.search.text = "";
  }

  void _onSearchTextChanged(String text) {
    // Perform search operations based on the text
  }

  void _submitSearch() {
    String query = homeController.search.text.trim();
    // Perform search operations based on the query
    print('Submit Query: $query');
    // Clear the search input
    homeController.getSpesifikData(query);

    // homeController.search.clear();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // FocusScope.of(context).unfocus(); // Unfocus the text field
        // _submitSearch();
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (BuildContext context) {
        //       return CardScreen();
        //     },
        //   ),
        // );
      },
      child: Container(
        padding: EdgeInsets.all(16),
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: Color(0xFFF2F3F2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(
              searchIcon,
              width: 20,
              height: 20,
            ),
            SizedBox(
              width: 8,
            ),
            Expanded(
              child: TextField(
                controller: homeController.search,
                onChanged: _onSearchTextChanged,
                decoration: InputDecoration.collapsed(
                  hintText: 'Cari Produk',
                  hintStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF7C7C7C),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
