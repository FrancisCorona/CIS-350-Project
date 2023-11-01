import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'database.dart';

// SharedPreferences is used to locally track what posts a user has liked

class LikeManager {
  //get instance of database class
  static final server = DataBase.getInstance();
  // Firestore collection reference
  static final CollectionReference postsCollection = server.getPostCollection();

  // SharedPreferences key to store liked post IDs
  static const _likedPostsKey = 'liked_posts';

  // Add a post to the liked posts list
  static Future<void> likePost(String postID) async {
    final prefs = await SharedPreferences.getInstance();
    final likedPosts = prefs.getStringList(_likedPostsKey) ?? [];
    if (!likedPosts.contains(postID)) {
      likedPosts.add(postID);
      await prefs.setStringList(_likedPostsKey, likedPosts);
      await server.addLike(postID);
    }
  }

  // Remove a post from the liked posts list
  static Future<void> unlikePost(String postID) async {
    final prefs = await SharedPreferences.getInstance();
    final likedPosts = prefs.getStringList(_likedPostsKey) ?? [];
    likedPosts.remove(postID);
    await prefs.setStringList(_likedPostsKey, likedPosts);
    await server.removeLike(postID);
  }

  // Check if a post is liked
  static Future<bool> isLiked(String postID) async {
    final prefs = await SharedPreferences.getInstance();
    final likedPosts = prefs.getStringList(_likedPostsKey) ?? [];
    return likedPosts.contains(postID);
  }
}
