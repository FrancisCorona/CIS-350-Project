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
  Stream<QuerySnapshot> getPosts(String selectedFilter) {
    CollectionReference postsCollection = FirebaseFirestore.instance.collection('posts');

    // Define a query reference
    Query query = postsCollection;

    if (selectedFilter == 'Recent') {
      query = query.orderBy('timeStamp', descending: true);
    } else if (selectedFilter == 'Oldest') {
      query = query.orderBy('timeStamp', descending: false);
    } else if (selectedFilter == 'Hottest') { // Need to implement hottest algorithm
      query = query.orderBy('timeStamp', descending: true);
    } else if (selectedFilter == 'Most Liked') {
      query = query.orderBy('likes', descending: true);
    } else { // Default if invalid filter gets selected somehow
      query = query.orderBy('timeStamp', descending: true);
    }

    // Return the stream of snapshots
    return query.snapshots();
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
