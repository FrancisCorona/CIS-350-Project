import 'package:flutter/material.dart';

class SearchBox extends StatefulWidget {
  const SearchBox({Key? key}) : super(key: key);

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        textAlignVertical: TextAlignVertical.center,
        controller: _searchController,
        decoration: InputDecoration(
            isCollapsed: true,
            filled: true,
            fillColor: Colors.white.withOpacity(0.5),
            focusedBorder:OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black12, width: 1.0),
              borderRadius: BorderRadius.circular(20.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: const BorderSide(color: Colors.black12, width: 1.0
              ),
            ),
            hintText: "Search Posts",
            //create the search icon on the left
            prefixIcon: const Icon(Icons.search, size: 30.0),
            //creates the X icon on the right
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                _searchController.clear();
              },
            )),
      ),
    );
  }
}
