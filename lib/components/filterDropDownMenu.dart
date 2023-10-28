import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

final List<String> list = <String>['Recent', 'Oldest', 'Hottest', 'Most Liked'];

class FilterDropDownMenu extends StatefulWidget {
  final Function(String) onFilterChanged;
  const FilterDropDownMenu({super.key, required this.onFilterChanged});
  @override
  State<FilterDropDownMenu> createState() => _FilterDropDownMenuState();
}

class _FilterDropDownMenuState extends State<FilterDropDownMenu> {
  String dropdownValue = list.first;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
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
              widget.onFilterChanged(dropdownValue);
            },
            buttonStyleData: ButtonStyleData(
              width: 135,
              padding: const EdgeInsets.only(right:6),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.black12,
                ),
              )
            ),
            iconStyleData: const IconStyleData(
              icon: Icon(
                Icons.filter_list_alt,
                color: Color(0x80000000),
                size: 25.0,
              ),
            ),
            dropdownStyleData: DropdownStyleData(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              )
            ),
            //Converts the list to a map with the key and value being the same
            items: list.map<DropdownMenuItem<String>>((value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Center(
                  child: Text(
                    value,
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.6),
                    )
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
