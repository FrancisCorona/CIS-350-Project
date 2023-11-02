import 'package:flutter/material.dart';

class DisLikeButton extends StatelessWidget {
  final bool isSelected;
  final void Function()? onTap;
  DisLikeButton({super.key, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Icon(
          Icons.thumb_down,
          color: isSelected ? Colors.white : Colors.grey,
        ));
  }
}
