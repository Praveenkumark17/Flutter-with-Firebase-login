import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dungen/models/dungen.dart';
import 'package:dungen/models/user.dart';

class Databaseservice {
  final String uid;
  Databaseservice({required this.uid});

  final CollectionReference logincollection =
      FirebaseFirestore.instance.collection('login');

  Future updateUserData(String sugars, String name, int strength) async {
    return await logincollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  //dungen list from snapshot
  List<Dungen?> _dungenListfromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs
        .map((val) => Dungen(
              name: (val.data() as Map<String, dynamic>)['name'] ?? '',
              strength: (val.data() as Map<String, dynamic>)['strength'] ?? 0,
              sugures: (val.data() as Map<String, dynamic>)['sugars'] ?? '',
            ))
        .toList();
    // print(snapshot.docs);
  }

  //get login stream
  Stream<List<Dungen?>?> get login {
    return logincollection.snapshots().map(_dungenListfromSnapshot);
  }

  //Userdata from snapshot
  UserData _userDatafromsnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return UserData(
      uid: uid,
      name: data['name'],
      sugars: data['sugars'],
      strength: data['strength'],
    );
  }

  //get user doc stream
  Stream<UserData> get userData {
    return logincollection.doc(uid).snapshots().map(_userDatafromsnapshot);
  }

//     Future<UserData> getUserData(String uid) async {
//   final userDoc = FirebaseFirestore.instance.collection('login').doc(uid);
//   final docSnapshot = await userDoc.get();
//   if (docSnapshot.exists) {
//     return UserData.fromMap(docSnapshot.data()!);
//   } else {
//     throw Exception('User not found');
//   }
// }
}
