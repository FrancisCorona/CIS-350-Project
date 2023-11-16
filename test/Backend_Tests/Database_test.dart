import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:lakervent/components/database.dart';
import 'package:mockito/mockito.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  final fakeDatabase = FakeFirebaseFirestore();
  await fakeDatabase.collection('posts').add({
    'likes': 3,
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
}
