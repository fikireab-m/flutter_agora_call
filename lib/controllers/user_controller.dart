import 'package:cloud_firestore/cloud_firestore.dart';

class UserController {
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('Users');

  Future<void> createUser(String userId, Map<String, dynamic> userData) async {
    return _usersCollection
        .doc(userId)
        .set(userData)
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<DocumentSnapshot> getUser(String userId) async {
    return _usersCollection
        .doc(userId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document data: ${documentSnapshot.data()}');
      } else {
        print('Document does not exist on the database');
      }
      return documentSnapshot;
    });
  }

  Future<QuerySnapshot> getAllUsers() async {
    return _usersCollection
        .get()
        .then((QuerySnapshot querySnapshot) => querySnapshot);
  }
}
