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
    when(query('message')).thenAnswer((_) async => 'Stub');
    //fetch data
    final postReference = await server.createPost("message");

    final snapshot = await postReference.get();
    final temp = snapshot.data()!;
    expect(temp['message'], "message");
  });
}

Future<String> _stub(String tag) async {
  var responses = ["Purr", "Meow"];
  return responses.removeAt(0);
}
