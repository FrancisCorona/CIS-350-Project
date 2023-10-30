import 'package:flutter/material.dart';
import 'package:lakervent/main.dart';
import 'post_page.dart';
import '../components/filterDropDownMenu.dart';
import "../components/database.dart";
import "../components/postStream.dart";
import "../components/search_box.dart";

// Define class HomePage that extends StatefulWidget
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState(); // Create and return an instance of _HomePageState
}

// Define the state class for HomePage
class _HomePageState extends State<HomePage> {
  String postContents = "null"; // Initialize postContents with null
  String selectedFilter = 'Recent'; // Initialize the selected filter

final server = DataBase.getInstance(); // Create instance of DataBase class

  // Define a function to handle filter changes
  void onFilterChanged(String newFilter) {
    setState(() {
      selectedFilter = newFilter;
    });
  }

// Construct screen structure with colored background, app bar, and body content.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF8BD5FF),
      appBar: buildAppBar(),
      body: buildBody(),
      bottomNavigationBar: buildBottomAppBar(),
    );
  }

// Creates and configures the app bar.
  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: const Color(0xFF00B9FF),
      centerTitle: true,
      elevation: 0,
      title: const Text(
        "LakerVent",
        style: TextStyle(
          color: Color(0xFF0032A0),
          fontSize: 35,
          fontWeight: FontWeight.w700,
          height: 0.8,
        ),
      ),
    );
  }

// Main body of the screen with search box, filter, and post.
  Widget buildBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        buildSearchBoxAndFilterDropDownMenu(),
        Container(
          child: PostStream(selectedFilter: selectedFilter),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
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

              if (result != null && result.isNotEmpty) {
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