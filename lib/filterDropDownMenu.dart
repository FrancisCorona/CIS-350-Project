import 'package:flutter/material.dart';

final List<String> list = <String>['Recent', 'Oldest', 'Hottest', 'Most Liked'];

class FilterDropDownMenu extends StatefulWidget {
  const FilterDropDownMenu({super.key});
  @override
  State<FilterDropDownMenu> createState() => _FilterDropDownMenuState();
}

class _FilterDropDownMenuState extends State<FilterDropDownMenu> {
  String dropDownItem = list.first;
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: list.first,
      //When a new item is selected switch to that item
      onChanged: (String? value) {
        setState(() {
          dropDownItem = value!;
        });
      },
      //Convers the list to a map with the key and value being the same
      items: list.map<DropdownMenuItem<String>>((value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
