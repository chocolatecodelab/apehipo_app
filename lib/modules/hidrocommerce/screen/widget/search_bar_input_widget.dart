import 'package:Apehipo/modules/hidrocommerce/controller/hidrocommerce_controller.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';

class SearchBarInputWidget extends StatefulWidget {
  @override
  _SearchBarInputWidgettate createState() => _SearchBarInputWidgettate();
}

class _SearchBarInputWidgettate extends State<SearchBarInputWidget> {
  final String searchIcon = "../assets/icons/search_icon.svg";
  var hidrocommerceController = Get.put(HidrocommerceController());

  @override
  void initState() {
    super.initState();
    hidrocommerceController.search.text = "";
  }

  void _onSearchTextChanged(String text) {
    // Perform search operations based on the text
  }

  void _submitSearch() {
    String query = hidrocommerceController.search.text.trim();
    // Perform search operations based on the query
    print('Submit Query: $query');
    // Clear the search input
    hidrocommerceController.getSpesifikData(query);

    // hidrocommerceController.search.clear();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
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
            SizedBox(
              width: 8,
            ),
            Expanded(
              child: TextField(
                controller: hidrocommerceController.search,
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
