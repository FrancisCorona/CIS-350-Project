import 'package:flutter/material.dart';

class PostTag extends StatelessWidget {
  final String tag;
  PostTag({super.key, required this.tag});

  @override
  Widget build(BuildContext context) {
    if (tag.isNotEmpty) {
      return ConstrainedBox(
        constraints: BoxConstraints(maxWidth: MediaQuery
            .of(context)
            .size
            .width / 1.8), // Prevents the tag overflowing if too long
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: Colors.greenAccent,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child:
          Text(
            tag,
            softWrap: false,
            overflow: TextOverflow.clip,
            // style: const TextStyle(
            //   fontWeight: FontWeight.w600,
            //   color: Colors.black54,
            // ),
          ),
        ),
      );
    }  else {
      return const Spacer();
    }
  }
}
