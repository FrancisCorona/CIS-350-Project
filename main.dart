import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import "home_page.dart";

void main() => runApp(MaterialApp(
      title: "LakerVent",
      home: Home(),
      debugShowCheckedModeBanner: false,
    ));

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePage();
  }
}
