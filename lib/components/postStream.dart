import 'package:flutter/material.dart';
import 'database.dart';

class PostStream extends StatefulWidget {
  const PostStream({super.key});
  @override
  State<PostStream> createState() => _PostStream();
}

class _PostStream extends State<PostStream> {
  final server = DataBase();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: server.getPosts(),
        builder: (context, snapshot) {
          //show a loading circle
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final posts = snapshot.data!.docs;
          if (snapshot.data == null || posts.isEmpty) {
            //add later for if there are no posts
            return const Center(
              child:
                  Padding(padding: EdgeInsets.all(25), child: Text("no posts")),
            );
          }
          // Display the posts using a ListView.builder
          return Expanded(
              child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];
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
                      "5 minutes ago",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 8.0),
                      child: Text(
                        post['message'],
                        style: const TextStyle(
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ));
        });
  }
}
