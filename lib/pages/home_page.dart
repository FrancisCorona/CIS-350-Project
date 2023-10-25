import 'package:flutter/material.dart';
import 'package:lakervent/main.dart';
import 'post_page.dart';
import '../components/postObject.dart';
import '../components/filterDropDownMenu.dart';

class HomePage extends State<Home> {
  final _searchController = TextEditingController();
  String postContents = "null";
  final List<SocialMediaPost> posts = [ //placeholder for creating posts to test formatting
    SocialMediaPost('Ugh, parking at GVSU is a never-ending nightmare! Spent 30 minutes circling for a spot today. #ParkingProblems', DateTime.now().subtract(Duration(minutes: 5))),
    SocialMediaPost('Midterms are here, and I\'m drowning in assignments! Need some motivation and study buddies. #StressedStudent', DateTime.now().subtract(Duration(minutes: 43))),
    SocialMediaPost('Why does the Wi-Fi always decide to quit on me during online exams? Seriously, GVSU, we need better internet! #TechIssues', DateTime.now().subtract(Duration(minutes: 164))),
    SocialMediaPost('Does anyone else find Mackinac confusing as heck? Got lost AGAIN today. #LostAgain', DateTime.now().subtract(Duration(minutes: 893))),
    //add more posts here as needed
  ];

  @override
  Widget build(BuildContext context) {
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
          )
        ),
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
          // Display the posts using a ListView.builder
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.all(8.0),
                  margin: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      )
                    ],
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
                final newPost = SocialMediaPost(
                  result, // Use the postContents from PostPage
                  DateTime.now(),
                );

                setState(() {
                  posts.insert(0, newPost); // Insert the new post at the beginning of the list
                });
              }
            },
            // Specifying size of button and text within the button.
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF0032a0),
              minimumSize: Size(220, 60),
              textStyle: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w600),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0), // Add rounded corners
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