import 'package:flutter/material.dart';
import 'package:lakervent/main.dart';
import 'package:lakervent/database.dart';

class HomePage extends State<Home> {
  var server = DataBase();
  final _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text("LakerVent")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            //create the search bar
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(width: 0.8),
                  ),
                  hintText: "Search Posts",
                  //create the search icon on the left
                  prefixIcon: Icon(Icons.search, size: 30.0),
                  //creates the X icon on the right
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                    },
                  )),
            ),
          ),
          //posts
          StreamBuilder(
              //no data
              stream: server.getPosts(),
              builder: (context, snapshot) {
                final posts = snapshot.data!.docs;
                if (snapshot.data == null || posts.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(25),
                      child: Text("no posts"),
                    ),
                  );
                }
                return Expanded(
                    child: ListView.builder(
                        itemCount: posts.length,
                        itemBuilder: (context, index) {
                          final post = posts[index];

                          String message = post['message'];

                          return ListTile(title: Text(message));
                        }));
              })
        ],
      ),
    );
  }
}
