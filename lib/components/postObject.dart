import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'database.dart';

class SocialMediaPost {
  String content;
  DateTime timestamp;
  String timeAgo = 'null';
  static List<SocialMediaPost> posts = [];

  SocialMediaPost(this.content, this.timestamp) {
    timeAgo = formatTimeAgo(timestamp);

    // Schedule a timer to update the timeAgo property periodically
    const duration =
        Duration(minutes: 1); // Update every minute, adjust as needed
    Timer.periodic(duration, (timer) {
      timeAgo = formatTimeAgo(timestamp);
    });
  }

  String formatTimeAgo(DateTime time) {
    final now = DateTime.now();
    final difference = time.isBefore(now) ? now.difference(time) : Duration();

    if (difference.inMinutes < 60) {
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
