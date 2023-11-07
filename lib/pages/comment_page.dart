import 'package:flutter/material.dart';
import 'package:lakervent/components/postObject.dart';
import 'package:lakervent/components/database.dart';

class CommentPage extends StatefulWidget {
  final SocialMediaPost postObject;

  const CommentPage({super.key, required this.postObject});

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
      backgroundColor: const Color(0xFF00B9FF),
      centerTitle: true,
      elevation: 0,
      iconTheme: const IconThemeData(color: Color(0xFF0032A0)),
      title: const Text(
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget> [
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
            return Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
                itemCount: comments.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    // The first item is the post message
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.postObject.formatTimeAgo(widget.postObject.timeStamp),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                        Text(widget.postObject.message),
                        if (comments.isNotEmpty)
                          Container(
                            margin: const EdgeInsets.only(left:15, top: 5),
                            height: 20,
                            width: 1,
                            color: Colors.grey,
                          ),
                        if (comments.isEmpty)
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.all(25),
                            child: Text("no comments")
                          ),
                        )
                      ],
                    );
                  } else {
                    final commentSnapshot = comments[index - 1];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container( // Comment container
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 10),
                          decoration: BoxDecoration(
                            color: const Color(0x0D000000),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                formatTimeAgo(
                                    commentSnapshot['commentTime'].toDate()),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(commentSnapshot['commentText']),
                            ],
                          ),
                        ),
                        if (index < comments.length) // Adds a vertical separator between comments
                          Container(
                            margin: const EdgeInsets.only(left:15),
                            height: 20,
                            width: 1,
                            color: Colors.grey,
                          ),
                      ],
                    );
                  }
                },
              ),
            );
          },
        ),
        Container(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
            child: buildCommentInputField()
        )
      ],
    );
  }

  // Function to build and return an input field for writing the post.
  TextField buildCommentInputField() {
      return TextField(
        onEditingComplete: () {},
        textInputAction: TextInputAction.send,
        controller: _commentController,
        onSubmitted: (comment) {
          if (comment.isNotEmpty) {
            server.addComment(widget.postObject.postID, comment);
            _commentController.clear();
          }
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
          contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          counterText: "",
        ),
        maxLines: null,
        maxLength: 1000,
        autofocus: true,
    );
  }

  String formatTimeAgo(DateTime time) {
    final now = DateTime.now();
    final difference = time.isBefore(now) ? now.difference(time) : const Duration();

    if (difference.inSeconds < 60) {
      return 'Posted now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      final hours = difference.inHours;
      final remainingMinutes = difference.inMinutes % 60;
      final hoursDecimal = hours + (remainingMinutes / 60);
      return '${hoursDecimal.toStringAsFixed(1)}h ago';
    } else {
      final days = difference.inDays;
      final remainingHours = difference.inHours % 24;
      final daysDecimal = days + (remainingHours / 24);
      return '${daysDecimal.toStringAsFixed(1)}d ago';
    }
  }
}