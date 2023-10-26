import 'package:cloud_firestore/cloud_firestore.dart';

class DataBase {
  //Get a reference of the posts collection from the database
  static final CollectionReference posts =
      FirebaseFirestore.instance.collection('posts');

  //Post
  Stream<QuerySnapshot> getPosts() {
    final orderedPosts = FirebaseFirestore.instance
        .collection('posts')
        .orderBy('timeStamp', descending: false)
        .snapshots();
    return orderedPosts;
  }

  //create post
  Future<DocumentReference<Map<String, dynamic>>> createPost(String message) {
    final data = {
      "likes": 0,
      "message": message,
      "reportCount": 0,
      "timeStamp": Timestamp.now()
    };
    final post = FirebaseFirestore.instance.collection('posts').add(data);
    return post;
  }
}
