import 'package:cloud_firestore/cloud_firestore.dart';

import 'getAIData.dart';

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
    // Define a query reference
    Query query = posts;

    if (selectedFilter == 'Recent') {
      query = query.orderBy('timeStamp', descending: true);
    } else if (selectedFilter == 'Oldest') {
      query = query.orderBy('timeStamp', descending: false);
    } else if (selectedFilter == 'Hottest') {
      // Need to implement hottest algorithm
      query = query.orderBy('timeStamp', descending: true);
    } else if (selectedFilter == 'Most Liked') {
      query = query.orderBy('likes', descending: true);
    } else {
      // Default if invalid filter gets selected somehow
      query = query.orderBy('timeStamp', descending: true);
    }

    // Return the stream of snapshots
    return query.snapshots();
  }

  Stream<QuerySnapshot> getComments(String id) {
    return FirebaseFirestore.instance
        .collection('posts')
        .doc(id)
        .collection("Comments")
        .orderBy("commentTime")
        .snapshots();
  }

  Future<int> countComments(String id) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection("posts")
        .doc(id)
        .collection("Comments")
        .get();

    return querySnapshot.size;
  }


  //create post
  Future<DocumentReference<Map<String, dynamic>>> createPost(String message) async {
    final data = {
      "likes": 0,
      "message": message,
      "reportCount": 0,
      "timeStamp": Timestamp.now(),
      "tag": '',
    };
    final post = await FirebaseFirestore.instance.collection('posts').add(data);

    // Fetch the tag and update the post in the database with the generated tag
    final tag = await query(message);
    post.update({'tag': tag});

    return post;
  }

//add like to a post
  Future<void> addLike(String id) {
    return posts.doc(id).update({'likes': FieldValue.increment(1)});
  }

//increment the reportCount for a post by 1
  Future<void> report(String id) {
    return posts.doc(id).update({'reportCount': FieldValue.increment(1)});
  }

//remove a like from a post
  Future<void> removeLike(String id) {
    return posts.doc(id).update({'likes': FieldValue.increment(-1)});
  }

  void addComment(String id, String commentText) {
    posts.doc(id).collection("Comments").add({"commentText" : commentText, "commentTime" : Timestamp.now()});
  }

//getter for the posts collection reference
  CollectionReference getPostCollection() {
    return posts;
  }
}
