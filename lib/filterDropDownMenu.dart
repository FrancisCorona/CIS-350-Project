import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

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
    return Scaffold(
      body: Center(
        child: DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            alignment: AlignmentDirectional.center,
            isExpanded: true,
            value: dropdownValue,
            //When a new item is selected switch to that item
            onChanged: (String? value) {
              setState(() {
                dropdownValue = value!;
              });
            },
            buttonStyleData: ButtonStyleData(
              padding: const EdgeInsets.only(left: 0, right: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey,
              ),
            ),
            iconStyleData: const IconStyleData(
              icon: Icon(
                Icons.filter_list, // Replace with the icon you want to use
                size: 24, // Adjust the size as needed
                color: Colors.black, // Adjust the color as needed
              ),
              iconSize: 0,
            ),
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
      ),
    );
  }
}
