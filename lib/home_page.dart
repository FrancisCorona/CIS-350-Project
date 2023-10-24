import 'package:flutter/material.dart';
import 'package:lakervent/main.dart';
import 'package:lakervent/post.dart';

class HomePage extends State<Home> {
  final _searchController = TextEditingController();
  final List<SocialMediaPost> posts = [
    SocialMediaPost('User', 'Ugh, parking at GVSU is a never-ending nightmare! Spent 30 minutes circling for a spot today. 😡 #ParkingProblems', DateTime.now()),
    SocialMediaPost('User2', 'The food at the cafeteria is getting worse by the day. Can we please have some edible options? 🍔🙏 #QualityMatters', DateTime.now().subtract(Duration(minutes: 12))),
    SocialMediaPost('User3', 'Midterms are here, and I\'m drowning in assignments! Need some motivation and study buddies. 💻📚 #StressedStudent', DateTime.now().subtract(Duration(minutes: 43))),
    SocialMediaPost('User4', 'Does anyone else find Mackinac confusing as heck? Got lost AGAIN today. 🗺️😓 #LostAgain', DateTime.now().subtract(Duration(minutes: 192))),
    SocialMediaPost('User5', 'Why does the Wi-Fi always decide to quit on me during online exams? Seriously, GVSU, we need better internet! 📶😩 #TechIssues', DateTime.now().subtract(Duration(minutes: 893))),
    SocialMediaPost('User6', 'This is another post', DateTime.now().subtract(Duration(minutes: 9023))),
    SocialMediaPost('User7', 'This is also another post', DateTime.now().subtract(Duration(hours: 34))),
    // Add more posts here as needed
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[600],
        centerTitle: true,
        title: const Text("LakerVent",
          style: TextStyle(
            color: Color(0xFF0032A0),
            fontSize: 35,
            fontFamily: 'Tinos',
            fontWeight: FontWeight.w700,
            height: 0.8,
          )
        ),
      ),
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
            ),
          ),
        ],
      ),
    );
  }
}