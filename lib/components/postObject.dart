import 'package:flutter/material.dart';
import 'like_button.dart';
import 'like_manager.dart';
import 'comment_button.dart';

class SocialMediaPost extends StatefulWidget {
  final String postID;
  final String message;
  final DateTime timeStamp;
  final int likes;
  final int reportCount;

  const SocialMediaPost(
      {Key? key,
      required this.message,
      required this.timeStamp,
      required this.likes,
      required this.reportCount,
      required this.postID})
      : super(key: key);

  @override
  State<SocialMediaPost> createState() => _SocialMediaPostState();
}

class _SocialMediaPostState extends State<SocialMediaPost> {
  bool isLiked = false;

  String getMessage() {
    return widget.message;
  }

  @override
  void initState() {
    super.initState();
    _loadLikedState();
  }

  Future<void> _loadLikedState() async {
    final liked = await LikeManager.isLiked(widget.postID);
    setState(() {
      isLiked = liked;
    });
  }

  Future<void> toggleLike() async {
    setState(() {
      isLiked = !isLiked;
    });

    if (isLiked) {
      await LikeManager.likePost(widget.postID);
    } else {
      await LikeManager.unlikePost(widget.postID);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: const [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 5,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                formatTimeAgo(widget.timeStamp),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              const Icon(
                Icons.flag,
                color: Colors.grey,
                size: 20,
              )
            ],
          ),
          // Message Contents
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: Text(
              widget.message,
              style: const TextStyle(
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          // Comment footer: Comments and Likes
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Comments
              CommentButton(postObject: widget),
              // Like heart
              Row(
                children: [
                  Text(
                    widget.likes.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 1),
                  LikeButton(
                    isLiked: isLiked,
                    onTap: () {
                      toggleLike();
                    },
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  String formatTimeAgo(DateTime time) {
    final now = DateTime.now();
    final difference = time.isBefore(now) ? now.difference(time) : Duration();

    if (difference.inSeconds < 60) {
      return 'Posted now';
    } else if (difference.inMinutes < 60) {
      return 'Posted ${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      final hours = difference.inHours;
      final remainingMinutes = difference.inMinutes % 60;
      final hoursDecimal = hours + (remainingMinutes / 60);
      return 'Posted ${hoursDecimal.toStringAsFixed(1)}h ago';
    } else {
      final days = difference.inDays;
      final remainingHours = difference.inHours % 24;
      final daysDecimal = days + (remainingHours / 24);
      return 'Posted ${daysDecimal.toStringAsFixed(1)}d ago';
    }
  }
}
