import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'pages/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'components/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    title: "LakerVent",
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

//Define a StatefulWidget class
class Home extends StatefulWidget {
  // Constructor for Home class
  const Home({Key? key});

// Override createState method
  @override
  _HomeState createState() {
    //Return an instance of _HomeState class
    return _HomeState();
  }
}

// Define a private state class _HomeState that extends State<Home>
class _HomeState extends State<Home> {
  // Override build method to define UI
  @override
  Widget build(BuildContext context) {
    // Return instance of HomePage
    return HomePage();
  }
}
