import 'package:flutter/material.dart';
import 'home_page.dart';

void main() => runApp(const MaterialApp(
      title: "LakerVent",
      home: Home(),
      debugShowCheckedModeBanner: false,
    ));

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<StatefulWidget> createState() {
    return HomePage();
  }
}
