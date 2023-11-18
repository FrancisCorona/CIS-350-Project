import 'package:cloud_firestore/cloud_firestore.dart';
import 'getAIData.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';

//implement the Singleton design pattern
class DataBase {
  //Get a reference of the posts collection from the database
  static dynamic posts = FirebaseFirestore.instance.collection('posts');

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
    return posts
        .doc(id)
        .collection("Comments")
        .orderBy("commentTime")
        .snapshots();
  }

  Future<int> countComments(String id) async {
    final querySnapshot = await posts.doc(id).collection("Comments").get();

    return querySnapshot.size;
  }

  //create post
  Future<DocumentReference<Map<String, dynamic>>> createPost(
      String message) async {
    final data = {
      "likes": 0,
      "message": message,
      "reportCount": 0,
      "timeStamp": Timestamp.now(),
      "tag": '',
    };
    final post = await posts.add(data);

    // Fetch the tag and update the post in the database with the generated tag
    //  final tag = await query(message);
    //post.update({'tag': tag});

    return post;
  }

//add like to a post
  Future<void> addLike(String id) {
    try {
      return posts.doc(id).update({'likes': FieldValue.increment(1)});
    } catch (error) {
      throw Exception("Error document ID is not valid. $error");
    }
  }

//remove a like from a post
  Future<void> removeLike(String id) {
    try {
      return posts.doc(id).update({'likes': FieldValue.increment(-1)});
    } catch (error) {
      throw Exception("Error document ID is not valid. $error");
    }
  }

  //Add report to a post
  Future<void> report(String id) {
    try {
      return posts.doc(id).update({'reportCount': FieldValue.increment(1)});
    } catch (error) {
      throw Exception("Error document ID is not valid. $error");
    }
  }

  //remove a report from a post
  Future<void> removeReport(String id) {
    try {
      return posts.doc(id).update({'reportCount': FieldValue.increment(-1)});
    } catch (error) {
      throw Exception("Error document ID is not valid. $error");
    }
  }

  void addComment(String id, String commentText) {
    posts
        .doc(id)
        .collection("Comments")
        .add({"commentText": commentText, "commentTime": Timestamp.now()});
  }

//getter for the posts collection reference
  CollectionReference getPostCollection() {
    return posts;
  }

//provides a way to change the collection reference for testing
  void changeCollectionReference(reference) {
    //checks to make sure the refernce is either a CollectionReference of is a reference for testing
    if (reference is CollectionReference ||
        reference is FakeFirebaseFirestore) {
      posts = reference;
    } else {
      throw "Invalid Collection reference";
    }
  }
}
