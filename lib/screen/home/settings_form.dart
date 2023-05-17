import 'package:dungen/models/user.dart';
import 'package:dungen/service/database.dart';
import 'package:dungen/shared/constants.dart';
import 'package:dungen/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Settings_Form extends StatefulWidget {
  const Settings_Form({super.key});

  @override
  State<Settings_Form> createState() => _Settings_FormState();
}

class _Settings_FormState extends State<Settings_Form> {
  final _formkey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3'];

  //form values
  String? currentName;
  String? currentSuger;
  int? currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users?>(context);

    return StreamBuilder<UserData>(
        stream: Databaseservice(uid: user!.uid).userData,
        builder: (context, snapshot) {
          print(snapshot.hasData);
          if (snapshot.hasData) {
            UserData? userData = snapshot.data;
            return Form(
              key: _formkey,
              child: Column(
                children: [
                  const Text(
                    'Update dungen List',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    initialValue: currentName ?? userData?.name,
                    decoration: textinputDecoration.copyWith(
                      hintText: 'Enter the name'
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter valid name';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      setState(() {
                        currentName = value;
                      });
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  //dropdown
                  DropdownButtonFormField(
                    decoration: textinputDecoration,
                    value: currentSuger ?? userData?.sugars,
                    items: sugars.map((sugar) {
                      return DropdownMenuItem(
                        child: Text('$sugar sugar'),
                        value: sugar,
                      );
                    }).toList(),
                    onChanged: (value) {
                      currentSuger = value;
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  //slider
                  Slider(
                    value: currentStrength?.toDouble() ??
                        (userData!.strength).toDouble(),
                    activeColor:
                        Colors.green[currentStrength ?? userData!.strength],
                    inactiveColor: Colors.green[100],
                    min: 100.0,
                    max: 900.0,
                    divisions: 8,
                    onChanged: (value) {
                      setState(() {
                        currentStrength = value.toInt();
                      });
                    },
                  ),
                  // Text(currentStrength as String),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formkey.currentState!.validate()) {
                        await Databaseservice(uid: user.uid).updateUserData(
                          currentSuger ?? userData!.sugars,
                          currentName ?? userData!.name,
                          currentStrength ?? userData!.strength,
                        );
                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.green[400]),
                  )
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
