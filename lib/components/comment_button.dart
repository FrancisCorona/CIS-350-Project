import 'package:flutter/material.dart';
import 'package:lakervent/pages/comment_page.dart';
import 'package:lakervent/components/postObject.dart';

import 'database.dart';

class CommentButton extends StatelessWidget {
  final SocialMediaPost postObject;
  final DataBase server = DataBase.getInstance();

  CommentButton({super.key, required this.postObject});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
      future: server.countComments(postObject.postID),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Return a loading indicator or placeholder text while waiting for the count
          return const Row(
            children: [
              Icon(
                Icons.chat_bubble,
                color: Colors.grey,
                size: 18.0,
              ),
              SizedBox(width: 5),
              Text(
                "0 Comments",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
              ),
            ],
          );
        } else {
          if (snapshot.hasError) {
            // Return an error message if the count couldn't be retrieved
            return const Text("Comments");
          } else {
            // Use the count in the Text widget
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
              child: Row(
                children: [
                  const Icon(
                    Icons.chat_bubble,
                    color: Colors.grey,
                    size: 18.0,
                  ),
                  SizedBox(width: 5),
                  Text(
                    "${snapshot.data} Comments",
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          }
        }
      },
    );
  }
}
