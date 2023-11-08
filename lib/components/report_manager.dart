import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'database.dart';

class ReportManager {
  static final server = DataBase.getInstance();
  static final CollectionReference postsCollection = server.getPostCollection();

  static const _reportedPostsKey = 'reported_posts';
  static const _unreportedPostsKey = 'unreported_posts';

  static Future<void> reportPost(String postID) async {
    final prefs = await SharedPreferences.getInstance();
    final reportedPosts = prefs.getStringList(_reportedPostsKey) ?? [];
    final unreportedPosts = prefs.getStringList(_unreportedPostsKey) ?? [];

    if (!reportedPosts.contains(postID)) {
      reportedPosts.add(postID);
      await prefs.setStringList(_reportedPostsKey, reportedPosts);
      await server.reportPost(postID);
      await server.report(postID);
    }

    // Remove postID from unreportedPosts if it was there
    if (unreportedPosts.contains(postID)) {
      unreportedPosts.remove(postID);
      await prefs.setStringList(_unreportedPostsKey, unreportedPosts);
    }
  }

  static Future<void> unreportPost(String postID) async {
    final prefs = await SharedPreferences.getInstance();
    final reportedPosts = prefs.getStringList(_reportedPostsKey) ?? [];

    if (reportedPosts.contains(postID)) {
      reportedPosts.remove(postID);
      await prefs.setStringList(_reportedPostsKey, reportedPosts);
    }

    // Add postID to unreportedPosts
    final unreportedPosts = prefs.getStringList(_unreportedPostsKey) ?? [];
    if (!unreportedPosts.contains(postID)) {
      unreportedPosts.add(postID);
      await prefs.setStringList(_unreportedPostsKey, unreportedPosts);
    }
  }

  static Future<bool> isReported(String postID) async {
    final prefs = await SharedPreferences.getInstance();
    final reportedPosts = prefs.getStringList(_reportedPostsKey) ?? [];
    return reportedPosts.contains(postID);
  }

  static Future<bool> isUnreported(String postID) async {
    final prefs = await SharedPreferences.getInstance();
    final unreportedPosts = prefs.getStringList(_unreportedPostsKey) ?? [];
    return unreportedPosts.contains(postID);
  }
}
