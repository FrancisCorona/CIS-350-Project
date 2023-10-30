import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'pages/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'components/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'LakerVent',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    title: "LakerVent",
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}); 

  @override
  State<StatefulWidget> createState() {
    return HomePage();

  }
}
