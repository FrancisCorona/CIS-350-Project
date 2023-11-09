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
  //sharedPreferences key to store disliked post IDS
  static const _disLikedPostsKey = 'disLiked_posts';

  // Add a post to the liked posts list
  static Future<void> likePost(String postID) async {
    final prefs = await SharedPreferences.getInstance();
    final likedPosts = prefs.getStringList(_likedPostsKey) ?? [];
    final disLikedPosts = prefs.getStringList(_disLikedPostsKey) ?? [];
    //if post is currently disliked, remove it
    if (disLikedPosts.contains(postID) && !likedPosts.contains(postID)) {
      removedisLike(postID);
    }
    if (!likedPosts.contains(postID)) {
      likedPosts.add(postID);
      await prefs.setStringList(_likedPostsKey, likedPosts);
      await server.addLike(postID);
    }
  }

//add a post to the disliked post list
  static Future<void> disLikePost(String postID) async {
    final prefs = await SharedPreferences.getInstance();
    final disLikedPosts = prefs.getStringList(_disLikedPostsKey) ?? [];
    final likedPosts = prefs.getStringList(_likedPostsKey) ?? [];
    //If post is currently liked, unlike the post
    if (likedPosts.contains(postID) && !disLikedPosts.contains(postID)) {
      unlikePost(postID);
    }
    if (!disLikedPosts.contains(postID)) {
      disLikedPosts.add(postID);
      await prefs.setStringList(_disLikedPostsKey, disLikedPosts);
      await server.removeLike(postID);
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

  //remove a psot from the disliked post list
  static Future<void> removedisLike(String postId) async {
    final prefs = await SharedPreferences.getInstance();
    final disLikedPosts = prefs.getStringList(_disLikedPostsKey) ?? [];
    disLikedPosts.remove(postId);
    await prefs.setStringList(_disLikedPostsKey, disLikedPosts);
    await server.addLike(postId);
  }

  // Check if a post is liked
  static Future<bool> isLiked(String postID) async {
    final prefs = await SharedPreferences.getInstance();
    final likedPosts = prefs.getStringList(_likedPostsKey) ?? [];
    return likedPosts.contains(postID);
  }

//check if a post is disliked
  static Future<bool> isDisLiked(String postID) async {
    final prefs = await SharedPreferences.getInstance();
    final disLikedPosts = prefs.getStringList(_disLikedPostsKey) ?? [];
    return disLikedPosts.contains(postID);
  }
}