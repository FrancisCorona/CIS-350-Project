import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:lakervent/components/database.dart';
import 'package:mockito/mockito.dart';
import 'package:lakervent/components/getAIData.dart';

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
    'likes': 2,
    'message': "testing",
    'reportCount': 0,
    'tag': "test",
    'timeStamp': Timestamp.now(),
  });
  final fakeCollection = fakeDatabase.collection('posts');

  final server = DataBase.getInstance();
  server.changeCollectionReference(fakeCollection);
  test("Test createPost method", () async {
    //when the function asks the ai for data give it test instead of running it
    //when(query('message')).thenAnswer((_) async => 'Stub');
    //fetch data
    final postReference = await server.createPost("message");

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
    server.addLike('addLike');
    //get the post using the postId we createed
    var documentReference = fakeCollection.doc('addLike');
    final snapshot = await documentReference.get();

    expect(snapshot['likes'], 2);
  });
  test("test add like with invalid ID", () async {
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
    server.removeReport('removeReport');
    //get the post using the postId we createed
    var documentReference = fakeCollection.doc('removeReport');
    final snapshot = await documentReference.get();

    expect(snapshot['reportCount'], -1);
  });
  test("test report with invalid ID", () async {
    expect(server.removeReport('4543g3'), throwsException);
  });
}

Future<String> _stub(String tag) async {
  var responses = ["Purr", "Meow"];
  return responses.removeAt(0);
}
