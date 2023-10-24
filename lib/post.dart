import 'package:flutter/material.dart';

// Creating a class called PostPage that extends StatelessWidget.
class PostPage extends StatelessWidget {
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
          children: [
          
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Write your post",
                  border: InputBorder.none,
                ),
                maxLines: null,
              ),
            ),
            Spacer(),

            Container(
              margin: EdgeInsets.only(bottom: 20.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(150, 60),
                  textStyle: TextStyle(fontSize: 24.0),
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5.0),
                  child: Text("Post"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}