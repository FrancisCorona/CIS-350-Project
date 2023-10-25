import 'package:flutter/material.dart';
import 'package:lakervent/main.dart';
import 'post.dart';
import 'filterDropDownMenu.dart';

class HomePage extends State<Home> {
  final _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text("LakerVent")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: 50,
            padding: const EdgeInsets.only(
              top: 5,
              left: 10,
              right: 10,
              bottom: 5,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  //create the search bar
                  child: TextField(
                    textAlignVertical: TextAlignVertical.center,
                    controller: _searchController,
                    decoration: InputDecoration(
                        isCollapsed: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: const BorderSide(width: 0.8),
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
                  ),
                const SizedBox(width: 10),
                Container(
                  width: 167,
                  child: FilterDropDownMenu(),
                ),
              ],
            ),
          ),
          // Wrapping the ElevatedButton with Align and Expanded.
          Expanded(
            child: Align(
              // Align the button to the bottom center of the screen.
              alignment: Alignment(0.0, 0.90),
              child: ElevatedButton(
                onPressed: () {
                  // Handle the post button click.
                  Navigator.push(
                    context,
                    // Navigate to the PostPage when the button is clicked.
                    MaterialPageRoute(builder: (context) => PostPage()),
                  );
                },
                // Specifying size of button and text within the button.
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(220, 50),
                    textStyle: TextStyle(fontSize: 30.0)),
                // Display "New Post" as the button's text.
                child: Text("New Post"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
