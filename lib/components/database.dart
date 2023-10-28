import 'package:cloud_firestore/cloud_firestore.dart';

//implement the Singleton design pattern
class DataBase {
  //Get a reference of the posts collection from the database
  static final CollectionReference posts =
      FirebaseFirestore.instance.collection('posts');

  static DataBase instance = DataBase._();
  //Make the constructor private
  DataBase._();

  static DataBase getInstance() {
    return instance;
  }

  //Post
  Stream<QuerySnapshot> getPosts() {
    final orderedPosts = FirebaseFirestore.instance
        .collection('posts')
        .orderBy('timeStamp', descending: true)
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
