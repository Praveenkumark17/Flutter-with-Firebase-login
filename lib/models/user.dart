class Users {
  final String uid;

  Users({required this.uid});
}

class UserData {
  final String uid;
  final String name;
  final String sugars;
  final int strength;

  UserData({required this.uid,required this.name,required this.sugars,required this.strength});

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      uid: map['uid'],
      name: map['name'],
      sugars: map['sugars'],
      strength: map['strength'],
    );
  }
}
