import 'package:flutter/material.dart';
import 'package:dungen/screen/authenticate/register.dart';
import 'package:dungen/screen/authenticate/sign_in.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showsignin = true;
  void toggleView() {
    setState(() {
      showsignin = !showsignin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showsignin) {
      return SignIn(toggleView: toggleView);
    } else {
      return Register(toggleView: toggleView);
    }
  }
}
