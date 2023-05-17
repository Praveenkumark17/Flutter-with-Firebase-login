import 'package:flutter/material.dart';
import 'package:dungen/models/user.dart';
import 'package:dungen/screen/authenticate/authenticate.dart';
import 'package:dungen/screen/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users?>(context);
    print(user);
    if (user == null) {
      return const Authenticate();
    } else {
      return Home();
    }
  }
}
