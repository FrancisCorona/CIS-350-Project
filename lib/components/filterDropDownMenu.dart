import 'package:flutter/material.dart';

final List<String> list = <String>['Recent', 'Oldest', 'Hottest', 'Most Liked'];

class FilterDropDownMenu extends StatefulWidget {
  const FilterDropDownMenu({super.key});
  @override
  State<FilterDropDownMenu> createState() => _FilterDropDownMenuState();
}

class _FilterDropDownMenuState extends State<FilterDropDownMenu> {
  String dropdownValue = list.first;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      padding: EdgeInsets.all(7),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black26, width: 1.0), // Border style
        borderRadius: BorderRadius.circular(20.0), // Rounded corners
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          alignment: AlignmentDirectional.center,
          isDense: true,
          isExpanded: true,
          iconSize: 20,
          icon: Icon(
            Icons.filter_alt,
            color: Colors.grey,
            size: 25.0,
          ),
          value: dropdownValue,
          //When a new item is selected switch to that item
          onChanged: (String? value) {
            setState(() {
              dropdownValue = value!;
            });
          },
          //Converts the list to a map with the key and value being the same
          items: list.map<DropdownMenuItem<String>>((value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Center(
                child: Text(value),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
