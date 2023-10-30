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
          return const Center(
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
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final postSnapshot = posts[index];
                //Post card
                return SocialMediaPost(
                    message: postSnapshot['message'],
                    timeStamp: postSnapshot['timeStamp'].toDate(),
                    likes: postSnapshot['likes'],
                    reportCount: postSnapshot['reportCount'],
                    postID: postSnapshot.id,
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