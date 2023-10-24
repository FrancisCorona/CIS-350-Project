import 'package:flutter/material.dart';

class PostPage extends StatefulWidget {
  @override
  _PostPageState createState() => _PostPageState();
}

// Creating a class called PostPage that extends StatelessWidget.
class _PostPageState extends State<PostPage> {
  String postContents = 'null';
  late String text;

  @override
  // Override the build method to define the widget's structure and appearance.
  Widget build(BuildContext context) {
    // This provides a basic app structure with an app bar and body.
    return Scaffold(
      // Set the app bar title.
      appBar: AppBar(centerTitle: true, title: const Text("Create a Post")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: "Write your post",
                  border: InputBorder.none,
                ),
                maxLines: null,
                onChanged: (newText) {
                    postContents = newText;
                },
              ),
            ),
            const Spacer(),

            Container(
              margin: const EdgeInsets.only(bottom: 20.0),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    text = postContents;
                  });
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(150, 60),
                  textStyle: const TextStyle(fontSize: 24.0),
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: const Text("Post"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}