import 'package:flutter/material.dart';
import 'package:lakervent/pages/comment_page.dart';
import 'package:lakervent/components/postObject.dart';

class CommentButton extends StatelessWidget {
  final SocialMediaPost postObject;

  CommentButton({super.key, required this.postObject});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to the comment_page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return CommentPage(postObject: postObject);
            },
          ),
        );
      },
      child: const Row(children: [
        Icon(
          Icons.chat_bubble,
          color: Colors.grey,
          size: 18.0,
        ),
        SizedBox(width: 5),
        Text("Comments",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ))
      ]),
    );
  }
}
