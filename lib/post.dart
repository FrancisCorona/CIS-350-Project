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
          ],
        ),
      ),
    );
  }
}
