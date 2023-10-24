import 'package:flutter/material.dart';
import 'package:lakervent/main.dart';
import 'post_page.dart';
import 'postObject.dart';

class HomePage extends State<Home> {
  final _searchController = TextEditingController();
  final List<SocialMediaPost> posts = [ //placeholder for creating posts to test formatting
    SocialMediaPost('Ugh, parking at GVSU is a never-ending nightmare! Spent 30 minutes circling for a spot today. #ParkingProblems', DateTime.now()),
    //add more posts here as needed
  ];

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
                  contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
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
                )
              ),
            ),
          ),
          // Display the posts using a ListView.builder
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.all(8.0),
                  margin: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.0, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        posts[index].timeAgo,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                      Padding (
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                        child: Text(
                          posts[index].content,
                          style: const TextStyle(
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            )
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
                  textStyle: TextStyle(fontSize: 30.0)
                ),
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