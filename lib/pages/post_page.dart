import 'package:flutter/material.dart';

class PostPage extends StatefulWidget {
  @override
  _PostPageState createState() => _PostPageState();
}

// Creating a class called PostPage that extends StatelessWidget.
class _PostPageState extends State<PostPage> {
  String postContents = '';
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

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Color(0xFF00B9FF),
      centerTitle: true,
      elevation: 0,
      iconTheme: IconThemeData(color: Color(0xFF0032A0)),
      title: Text(
        "Create a Post",
        style: TextStyle(
          color: Color(0xFF0032A0),
          fontSize: 25,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget buildPostContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          buildPostInputField(),
          const Spacer(),
          buildPostButton(),
        ],
      ),
    );
  }

  TextField buildPostInputField() {
    return TextField(
      decoration: InputDecoration(
        labelText: "Write your post",
        border: InputBorder.none,
      ),
      maxLines: null,
      autofocus: true,
      onChanged: (newText) {
        setState(() {
          postContents = newText;
        });
      },
    );
  }

  ElevatedButton buildPostButton() {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          text = postContents;
        });
        Navigator.of(context).pop(postContents);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF0032a0),
        minimumSize: const Size(220, 50),
        textStyle: const TextStyle(fontSize: 24.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: const Text("Post"),
      ),
    );
  }
}