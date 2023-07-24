import '.././modules/cards/card_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SearchBarWidgets extends StatefulWidget {
  @override
  _SearchBarWidgetState createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidgets> {
  final String searchIcon = "../assets/icons/search_icon.svg";
  TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchTextChanged(String text) {
    // Perform search operations based on the text
    print('Search Query: $text');
  }

  void _submitSearch() {
    String query = _searchController.text.trim();
    // Perform search operations based on the query
    print('Search Query: $query');
    // Clear the search input
    _searchController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); // Unfocus the text field
        _submitSearch();
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return CardScreen();
            },
          ),
        );
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
                controller: _searchController,
                onChanged: _onSearchTextChanged,
                onSubmitted: (_) => _submitSearch(),
                decoration: InputDecoration.collapsed(
                  hintText: 'Search',
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
