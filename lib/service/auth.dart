import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dungen/models/user.dart';
import 'package:dungen/service/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;


  // create model based in firebase user
  Users? _userFromFirebaseUser(User? user) {
    return user != null ? Users(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<Users?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  // sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign with email and pass
  Future signinwithemailandpass(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register with email and pass
  Future registerwithemailandpass(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      //create a new doc for the user with the uid
      await Databaseservice(uid: user!.uid)
          .updateUserData('0', 'Praveen', 100);
      return _userFromFirebaseUser(user);
      print('data insert');
    } catch (e) {
      print(e.toString());
      return null;
      print('data not insert');
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e);
    }
  }
}
