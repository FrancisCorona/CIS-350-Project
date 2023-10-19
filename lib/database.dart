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
}
