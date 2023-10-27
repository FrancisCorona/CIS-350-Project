import 'package:flutter/material.dart';
import 'package:lakervent/main.dart';
import 'post_page.dart';
import '../components/postObject.dart';
import '../components/filterDropDownMenu.dart';
import "../components/database.dart";
import "../components/postStream.dart";

class HomePage extends State<Home> {
  final _searchController = TextEditingController();
  String postContents = "null";

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
            padding: const EdgeInsets.only(
              top: 5,
              left: 10,
              right: 15,
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
                  child: FilterDropDownMenu(),
                ),
              ],
            ),
          ),
          Container(
            child: PostStream(),
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
