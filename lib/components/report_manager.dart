import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'database.dart';

class ReportManager {
  static final server = DataBase.getInstance();
  static final CollectionReference postsCollection = server.getPostCollection();

  static const _reportedPostsKey = 'reported_posts';

  static Future<void> reportPost(String postID) async {
    final prefs = await SharedPreferences.getInstance();
    final reportedPosts = prefs.getStringList(_reportedPostsKey) ?? [];

    if (!reportedPosts.contains(postID)) {
      reportedPosts.add(postID);
      await prefs.setStringList(_reportedPostsKey, reportedPosts);
      await server.reportPost(postID);
      await server.report(postID);
    }
  }

  static Future<void> unreportPost(String postID) async {
    final prefs = await SharedPreferences.getInstance();
    final reportedPosts = prefs.getStringList(_reportedPostsKey) ?? [];

    if (reportedPosts.contains(postID)) {
      reportedPosts.remove(postID);
      await prefs.setStringList(_reportedPostsKey, reportedPosts);
    }
  }

  static Future<bool> isReported(String postID) async {
    final prefs = await SharedPreferences.getInstance();
    final reportedPosts = prefs.getStringList(_reportedPostsKey) ?? [];
    return reportedPosts.contains(postID);
  }
}
