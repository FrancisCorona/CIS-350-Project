import 'package:flutter/material.dart';
import 'package:lakervent/main.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF00B9FF),
      body: Column(
        children: [
          // LakerVent title

          // Welcome message

          // Verification Question
        ],
      )
    );
  }
}
