import 'package:flutter/material.dart';
import 'dart:math';
import 'database.dart';
import 'postObject.dart';

class PostStream extends StatefulWidget {
  final String selectedFilter;

  const PostStream({required this.selectedFilter, Key? key}) : super(key: key);
  @override
  State<PostStream> createState() => _PostStream();
}

class _PostStream extends State<PostStream> {
  List<String> numbersList = NumberGenerator().numbers;
  final List<SocialMediaPost> postList = [];
  final server = DataBase.getInstance();
  String selectedFilter = 'Recent';

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: server.getPosts(widget.selectedFilter),
      builder: (context, snapshot) {
        //show a loading circle
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final posts = snapshot.data!.docs;
        if (snapshot.data == null || posts.isEmpty) {
          //in case the database is empty, have a message saying there are no posts
          return const Center(
            child:
                Padding(padding: EdgeInsets.all(25), child: Text("no posts")),
          );
        }
        // Display the posts using a ListView.builder
        return Expanded(
          child: RefreshIndicator.adaptive(
            onRefresh: _pullRefresh,
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final postSnapshot = posts[index];
                final post = SocialMediaPost(
                    postSnapshot['message'],
                    postSnapshot['timeStamp'].toDate(),
                    postSnapshot['likes'],
                    postSnapshot['reportCount']);
                postList.add(post);
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            post.timeAgo,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                          Icon(
                            Icons.flag,
                            color: Colors.grey,
                            size: 20,
                          )
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 8.0),
                        child: Text(
                          post.message,
                          style: const TextStyle(
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                       Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row( // Comments
                              children: [
                                Icon(
                                  Icons.chat_bubble,
                                  color: Colors.grey,
                                  size: 18.0,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  "Comments",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey,
                                  )
                                )
                              ]
                          ),
                          Row( // Like Heart
                            children: [
                              Text(
                                post.likes.toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey,
                                ),
                              ),
                              // SizedBox( // Unliked heart
                              //   child: Icon(
                              //   Icons.favorite_border,
                              //   color: Colors.grey,
                              //   size: 20.0,
                              // ),
                              // ),
                              // Liked heart
                              SizedBox(width: 1),
                              Icon(
                                Icons.favorite,
                                color: Colors.red,
                                size: 20.0,
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
          )
        );
      }
    );
  }
  Future<void> _pullRefresh() async {
    List<String> freshNumbers = await NumberGenerator().slowNumbers();
    setState(() {
      numbersList = freshNumbers;
    });
  }

  void updateFilter(String newFilter) {
    setState(() {
      selectedFilter = newFilter;
    });
  }
}

// pull-to-refresh code
class NumberGenerator {
  Future<List<String>> slowNumbers() async {
    return Future.delayed(const Duration(milliseconds: 1000), () => numbers,);
  }

  List<String> get numbers => List.generate(5, (index) => number);

  String get number => Random().nextInt(99999).toString();
}
