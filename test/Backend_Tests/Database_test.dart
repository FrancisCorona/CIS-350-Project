import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:lakervent/components/database.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  final fakeDatabase = FakeFirebaseFirestore();
  Duration duration = Duration(days: 1, minutes: 15);
  DateTime pastTime = DateTime.now().subtract(duration);

  //create comments to add to the comment collection later
  Map<String, dynamic> comment1 = {
    'commentText': 'Great post!',
    'commentTime': pastTime.subtract(Duration(minutes: 5)),
  };
  Map<String, dynamic> comment2 = {
    'commentText': 'Awesome content!',
    'commentTime': pastTime.subtract(Duration(minutes: 3)),
  };
//create a post with a given ID to use for comment tests
  await fakeDatabase.collection('posts').doc('commentPost').set({
    'likes': 3,
    'message': "testing",
    'reportCount': 0,
    'tag': "test",
    'timeStamp': pastTime,
  });
  //add the comments to the Comment collection
  await fakeDatabase
      .collection('posts')
      .doc('commentPost')
      .collection('Comments')
      .add(comment1);
  await fakeDatabase
      .collection('posts')
      .doc('commentPost')
      .collection('Comments')
      .add(comment2);
  //create another post for testing
  await fakeDatabase.collection('posts').add({
    'likes': 2,
    'message': "testing",
    'reportCount': 0,
    'tag': "test",
    'timeStamp': Timestamp.now(),
  });
  final fakeCollection = fakeDatabase.collection('posts');

  final server = DataBase.getInstance();
  server.changeCollectionReference(fakeCollection);
  test('Test getComments function', () async {
    //run the function were testing
    final comments = server.getComments('commentPost');
    List<DocumentSnapshot> snapshots = [];
    // Changes that data from a stream<QuerySnapshot> to List<DocumentSnapshot> and puts the data into snapshots
    await for (QuerySnapshot<Object?> querySnapshot in comments) {
      snapshots.addAll(querySnapshot.docs);
      break;
    }

    bool isSorted = true;
    //if emtpy then something must've gone wrong
    if (snapshots.isEmpty) {
      isSorted = false;
    } else {
      //checks to make sure posts are in ascending order
      for (int index = 0; index < snapshots.length - 1; index++) {
        DateTime currentPost = snapshots[index]['commentTime'].toDate();
        DateTime nextPost = snapshots[index + 1]['commentTime'].toDate();
        if (currentPost.isAfter(nextPost)) {
          isSorted = false;
        }
      }
    }
    expect(isSorted, true);
  });
  test('Test countComments', () async {
    //run the function were testing
    final commentCount = await server.countComments('commentPost');
    expect(commentCount, 2);
  });
  test('Test addComment', () async {
    const testID = "test";
    const testComment = 'Something random #!{}';
    //Make a post to add a comment to
    await fakeCollection.doc(testID).set({
      'likes': 3,
      'message': "testing",
      'reportCount': 0,
      'tag': "test",
      'timeStamp': pastTime,
    });
    //run the function were testing
    await server.addComment(testID, testComment);
    //get the comments from the post
    final comment = server.getComments(testID);
    List<DocumentSnapshot> snapshotList = [];
    // Changes that data from a stream<QuerySnapshot> to List<DocumentSnapshot> and puts the data into snapshots
    await for (QuerySnapshot<Object?> querySnapshot in comment) {
      snapshotList.addAll(querySnapshot.docs);
      break;
    }
    expect(snapshotList[0]['commentText'], testComment);
  });

  test("Test createPost method", () async {
    //run the function were testing
    final postReference = await server.createPost("message");
    //convert the post reference to a snapshot
    final snapshot = await postReference.get();
    expect(snapshot['message'], "message");
  });
  test("Test add Like", () async {
    //create a post with a certain amount of likes
    fakeCollection.doc("addLike").set({
      'likes': 1,
      'message': "testing",
      'reportCount': 0,
      'tag': "test",
      'timeStamp': Timestamp.now(),
    });
    //run the function were testing
    server.addLike('addLike');
    //get the post using the postId we createed
    var documentReference = fakeCollection.doc('addLike');
    final snapshot = await documentReference.get();

    expect(snapshot['likes'], 2);
  });
  test("test addLike with invalid ID", () async {
    expect(server.addLike('1234'), throwsException);
  });
  test("Test remove Like", () async {
    //create a post with a certain amount of likes
    fakeCollection.doc("removeLike").set({
      'likes': 8,
      'message': "testing",
      'reportCount': 0,
      'tag': "test",
      'timeStamp': Timestamp.now(),
    });
    //run the function were testing
    server.removeLike('removeLike');
    //get the post using the postId we createed
    var documentReference = fakeCollection.doc('removeLike');
    final snapshot = await documentReference.get();

    expect(snapshot['likes'], 7);
  });
  test("test remove like with invalid ID", () async {
    expect(server.addLike('00043'), throwsException);
  });
  test("Test report", () async {
    //create a post with a certain amount of likes
    fakeCollection.doc("report").set({
      'likes': 0,
      'message': "testing",
      'reportCount': 999999999999999998,
      'tag': "test",
      'timeStamp': Timestamp.now(),
    });
    //run the function were testing
    server.report('report');
    //get the post using the postId we createed
    var documentReference = fakeCollection.doc('report');
    final snapshot = await documentReference.get();

    expect(snapshot['reportCount'], 999999999999999999);
  });
  test("test report with invalid ID", () async {
    expect(server.report('-12'), throwsException);
  });
  test("Test removeReport", () async {
    //create a post with a certain amount of likes
    fakeCollection.doc("removeReport").set({
      'likes': 4,
      'message': "testing",
      'reportCount': 0,
      'tag': "test",
      'timeStamp': Timestamp.now(),
    });
    //run the function were testing
    server.removeReport('removeReport');
    //get the post using the postId we createed
    var documentReference = fakeCollection.doc('removeReport');
    final snapshot = await documentReference.get();

    expect(snapshot['reportCount'], -1);
  });
  test("test report with invalid ID", () async {
    expect(server.removeReport('4543g3'), throwsException);
  });
  test("Test getPostCollection method", () async {
    expect(server.getPostCollection(), fakeCollection);
  });
  test("Test changeCollectionReference method", () async {
    //create a random collection
    final testDataBase = FakeFirebaseFirestore();
    //run the method were testing
    server.changeCollectionReference(testDataBase);
    //get the collection from the database
    final collection = server.getPostCollection();
    expect(collection, testDataBase);
  });
  test("Test changeCollectionReference method with invalid input", () async {
    expect(
        server.changeCollectionReference(
            "Random String thats not a valid collection reference"),
        throwsException);
  });
}
