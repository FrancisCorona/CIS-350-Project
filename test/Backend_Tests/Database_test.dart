import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:lakervent/components/database.dart';
import 'package:mockito/mockito.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  final fakeDatabase = FakeFirebaseFirestore();
  Duration duration = Duration(days: 1, minutes: 15);
  DateTime pastTime = DateTime.now().subtract(duration);
  await fakeDatabase.collection('posts').add({
    'likes': 3,
    'message': "testing",
    'reportCount': 0,
    'tag': "test",
    'timeStamp': pastTime,
  });
  await fakeDatabase.collection('posts').add({
    'likes': 1,
    'message': "testing",
    'reportCount': 0,
    'tag': "test",
    'timeStamp': Timestamp.now(),
  });
  final fakeCollection = fakeDatabase.collection('posts');

  final server = DataBase.getInstance();
  server.changeCollectionReference(fakeCollection);

  test("Test createPost method", () async {
    //fetch data
    final postReference = await server.createPost("message");

    final snapshot = await postReference.get();
    final temp = snapshot.data()!;
    expect(temp['message'], "message");
  });
  test("Test getPosts method returns in decending order by time", () async {
    //fetch data
    Stream<QuerySnapshot<Object?>> posts = server.getPosts('Recent');

    //act
    List<DocumentSnapshot> snapshots = [];
    print("working");
    // Changes that data from a stream<QuerySnapshot> to List<DocumentSnapshot> and puts the data into snapshots
    await for (QuerySnapshot<Object?> querySnapshot in posts) {
      snapshots.addAll(querySnapshot.docs);
      break;
    }
    bool isSorted = true;
    //checks to see if the next post is before the current post
    for (int index = 0; index < snapshots.length - 1; index++) {
      DateTime currentPost = snapshots[index]['timeStamp'].toDate();
      DateTime nextPost = snapshots[index + 1]['timeStamp'].toDate();
      if (currentPost.isBefore(nextPost)) {
        isSorted = false;
      }
    }
    expect(isSorted, true);
  });
  test("Test getPosts method with 'recent' paramenter", () async {
    //fetch data
    Stream<QuerySnapshot<Object?>> posts = server.getPosts('Recent');

    //act
    List<DocumentSnapshot> snapshots = [];
    // Changes that data from a stream<QuerySnapshot> to List<DocumentSnapshot> and puts the data into snapshots
    await for (QuerySnapshot<Object?> querySnapshot in posts) {
      snapshots.addAll(querySnapshot.docs);
      break;
    }
    bool isSorted = true;
    //checks to see if the next post is before the current post
    for (int index = 0; index < snapshots.length - 1; index++) {
      DateTime currentPost = snapshots[index]['timeStamp'].toDate();
      DateTime nextPost = snapshots[index + 1]['timeStamp'].toDate();
      if (currentPost.isBefore(nextPost)) {
        isSorted = false;
      }
    }
    expect(isSorted, true);
  });
  test("Test getPosts method with 'oldest' paramenter", () async {
    //fetch data
    Stream<QuerySnapshot<Object?>> posts = server.getPosts('Oldest');

    //act
    List<DocumentSnapshot> snapshots = [];
    // Changes that data from a stream<QuerySnapshot> to List<DocumentSnapshot> and puts the data into snapshots
    await for (QuerySnapshot<Object?> querySnapshot in posts) {
      snapshots.addAll(querySnapshot.docs);
      break;
    }
    bool isSorted = true;
    //checks to see if the next post is after the current post
    for (int index = 0; index < snapshots.length - 1; index++) {
      DateTime currentPost = snapshots[index]['timeStamp'].toDate();
      DateTime nextPost = snapshots[index + 1]['timeStamp'].toDate();
      if (currentPost.isAfter(nextPost)) {
        isSorted = false;
      }
    }
    expect(isSorted, true);
  });
  test("Test getPosts method with 'Most Liked' paramenter", () async {
    //fetch data
    Stream<QuerySnapshot<Object?>> posts = server.getPosts('Most Liked');

    //act
    List<DocumentSnapshot> snapshots = [];
    // Changes that data from a stream<QuerySnapshot> to List<DocumentSnapshot> and puts the data into snapshots
    await for (QuerySnapshot<Object?> querySnapshot in posts) {
      snapshots.addAll(querySnapshot.docs);
      break;
    }
    bool isSorted = true;
    //checks to see if the next post is after the current post
    for (int index = 0; index < snapshots.length - 1; index++) {
      if (snapshots[index]['likes'] < snapshots[index + 1]['likes']) {
        isSorted = false;
      }
    }
    expect(isSorted, true);
  });
  test("Test getPosts method with unknown paramenter", () async {
    //fetch data
    Stream<QuerySnapshot<Object?>> posts = server.getPosts('Least Liked');

    //act
    List<DocumentSnapshot> snapshots = [];
    // Changes that data from a stream<QuerySnapshot> to List<DocumentSnapshot> and puts the data into snapshots
    await for (QuerySnapshot<Object?> querySnapshot in posts) {
      snapshots.addAll(querySnapshot.docs);
      break;
    }
    bool isSorted = true;
    //checks to see if the next post is before the current post
    for (int index = 0; index < snapshots.length - 1; index++) {
      DateTime currentPost = snapshots[index]['timeStamp'].toDate();
      DateTime nextPost = snapshots[index + 1]['timeStamp'].toDate();
      if (currentPost.isBefore(nextPost)) {
        isSorted = false;
      }
    }
    expect(isSorted, true);
  });
}
