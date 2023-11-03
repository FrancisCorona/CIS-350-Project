import 'package:flutter/material.dart';
import 'package:lakervent/components/postObject.dart';

class CommentPage extends StatefulWidget {
  final SocialMediaPost postObject;

  CommentPage({super.key, required this.postObject});

  @override
  _CommentPageState createState() => _CommentPageState();
}

// Creating a class called PostPage that extends StatelessWidget.
class _CommentPageState extends State<CommentPage> {
  String comment = '';
  late String text;

  @override
  // Override the build method to define the widget's structure and appearance.
  Widget build(BuildContext context) {
    // This provides a basic app structure with an app bar and body.
    return Scaffold(
      appBar: buildAppBar(),
      body: buildPostContent(),
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
  Widget buildPostContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(widget.postObject.message),
          buildCommentInputField(),
        ],
      ),
    );
  }

  // Function to build and return an input field for writing the post.
  TextField buildCommentInputField() {
    return TextField(
      decoration: InputDecoration(
        labelText: "Add a comment",
        border: InputBorder.none,
      ),
      maxLines: null,
      autofocus: true,
      onChanged: (newText) {
        setState(() {
          comment = newText;
        });
      },
    );
  }
}