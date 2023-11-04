import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lakervent/components/postObject.dart';
import 'package:lakervent/components/database.dart';

class CommentPage extends StatefulWidget {
  final SocialMediaPost postObject;

  CommentPage({super.key, required this.postObject});

  @override
  _CommentPageState createState() => _CommentPageState();
}

// Creating a class called PostPage that extends StatelessWidget.
class _CommentPageState extends State<CommentPage> {
  static final server = DataBase.getInstance();
  String comment = '';
  late String text;
  final _commentController = TextEditingController();

  @override
  // Override the build method to define the widget's structure and appearance.
  Widget build(BuildContext context) {
    // This provides a basic app structure with an app bar and body.
    return Scaffold(
      appBar: buildAppBar(),
      body: buildCommentContent(),
    );
  }

  // Function to build and return the app bar widget.
  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Color(0xFF00B9FF),
      centerTitle: true,
      elevation: 0,
      iconTheme: IconThemeData(color: Color(0xFF0032A0)),
      title: Text(
        "Add a comment",
        style: TextStyle(
          color: Color(0xFF0032A0),
          fontSize: 25,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // Function to build and return the main content of the page.
  Widget buildCommentContent() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget> [
          Text(widget.postObject.message),
          StreamBuilder(
            stream: server.getComments(widget.postObject.postID),
            builder: (context, snapshot) {
              //show a loading circle
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              final comments = snapshot.data!.docs;
              if (snapshot.data == null || comments.isEmpty) {
                //in case the database is empty, have a message saying there are no posts
                return const Center(
                  child: Padding(
                      padding: EdgeInsets.all(25),
                      child: Text("no comments")
                  ),
                );
              }
              return Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    final commentSnapshot = comments[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Text(commentSnapshot['commentText']),
                        ),
                        if (index < comments.length - 1)
                          Container(
                            height: 20,
                            width: 1,
                            color: Colors.grey,
                          ),
                      ],
                    );
                  },
                ),
              );
            },
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20,),
              child: buildCommentInputField()
          )
        ],
      ),
    );
  }

  // Function to build and return an input field for writing the post.
  TextField buildCommentInputField() {
      return TextField(
        textInputAction: TextInputAction.send,
        controller: _commentController,
        onSubmitted: (comment) {
          server.addComment(widget.postObject.postID,comment);
          _commentController.clear();
          },
        decoration: InputDecoration(
          isCollapsed: true,
          filled: true,
          fillColor: Colors.white.withOpacity(0.5),
          focusedBorder:OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFF0032A0), width: 1.0),
            borderRadius: BorderRadius.circular(20.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(color: Color(0xFF0032A0), width: 1.0
            ),
          ),
          hintText: "Add Comment...",
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        ),
        maxLines: null,
        autofocus: true,
    );
  }
}