import 'package:flutter/material.dart';

class ReportButton extends StatelessWidget {
  final bool isReported;
  void Function()? onTap;
  ReportButton({Key? key, required this.isReported, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        Icons.flag,
        color: isReported ? Colors.red : Colors.grey,
      ),
    );
  }
}
