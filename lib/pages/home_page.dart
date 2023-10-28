import 'package:flutter/material.dart';
import 'package:lakervent/main.dart';
import 'post_page.dart';
import '../components/filterDropDownMenu.dart';
import "../components/database.dart";
import "../components/postStream.dart";
import "../components/searchBox.dart";

class HomePage extends State<Home> {
  String postContents = "null";
  String selectedFilter = 'Recent'; // Initialize the selected filter

  // Define a function to handle filter changes
  void onFilterChanged(String newFilter) {
    setState(() {
      selectedFilter = newFilter;
    });
  }

  @override
  Widget build(BuildContext context) {
    final server = DataBase.getInstance();
    return Scaffold(
      backgroundColor: const Color(0xFF8BD5FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFF00B9FF),
        centerTitle: true,
        elevation: 0,
        title: const Text("LakerVent",
            style: TextStyle(
              color: Color(0xFF0032A0),
              fontSize: 35,
              fontWeight: FontWeight.w700,
              height: 0.8,
            )),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  //create the search bar
                  child: SearchBox(),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 135,
                  child: FilterDropDownMenu(
                    onFilterChanged: (filter) {
                      setState(() {
                        selectedFilter = filter; // Update the selected filter
                      });
                    }
                  )
                ),
              ],
            ),
          ),
          Container(
            child: PostStream(selectedFilter: selectedFilter),
          )
        ],
      ),
      // Wrapping the ElevatedButton with Align and Expanded.
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFF00B9FF),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          margin: EdgeInsets.only(top: 25.0),
          child: ElevatedButton(
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PostPage(),
                ),
              );

              if (result.isNotEmpty) {
                server.createPost(result);
              }
            },
            // Specifying size of button and text within the button.
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF0032a0),
              minimumSize: Size(220, 60),
              textStyle: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w600),
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(20.0), // Add rounded corners
              ),
            ),
            // Display "New Post" as the button's text.
            child: Text("New Post"),
          ),
        ),
      ),
    );
  }
}
