import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dungen/models/dungen.dart';
import 'package:dungen/models/user.dart';
import 'package:dungen/screen/home/dungen_list.dart';
import 'package:dungen/screen/home/settings_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dungen/service/auth.dart';
import 'package:dungen/service/database.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final AuthService _auth = AuthService();

  void showsettingpanel(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Colors.green[100],
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
            child: Settings_Form(),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users?>(context);

    FirebaseAuth auth = FirebaseAuth.instance;
    final Email = auth.currentUser!.email;
    String? Name;
    // String userId = auth.currentUser!.uid;
    // FirebaseFirestore firestore = FirebaseFirestore.instance;
    // final DocumentReference userDocRef = firestore.collection('login').doc(userId);


    return MultiProvider(
      providers: [
        StreamProvider<List<Dungen?>?>(
          create: (_) => Databaseservice(uid: '').login,
          initialData: null,
        ),
      ],
      child: StreamBuilder<UserData?>(
        stream: Databaseservice(uid: user!.uid).userData,
        builder: (context, snapshot) {
          UserData? userData = snapshot.data;
          return Scaffold(
              backgroundColor: Colors.green[100],
              appBar: AppBar(
                title: Text("Home Page"),
                backgroundColor: Colors.green[400],
                elevation: 0.0,
                actions: [
                  PopupMenuButton(
                    onSelected: (value) {
                      // Perform the action based on the selected value
                      print('Selected action: $value');
                      if (value == 1) {
                        showsettingpanel(context);
                      }
                    },
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem(
                          value: 1,
                          child: Row(
                            children: const [
                              Icon(
                                Icons.settings,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                "Settings",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ];
                    },
                  ),
                ],
              ),
              drawer: Drawer(
                backgroundColor: Colors.green[100],
                child: Column(children: [
                  UserAccountsDrawerHeader(
                    decoration: BoxDecoration(color: Colors.green[400]),
                    accountName: Text("praveen"),
                    accountEmail: Text(Email!),
                    currentAccountPicture:
                        CircleAvatar(backgroundColor: Colors.green[50]),
                  ),
                  Expanded(
                    child: Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: ElevatedButton(
                          onPressed: () async {
                            await _auth.signOut();
                            print('logout');
                          },
                          child: const Text('Log Out'),
                          style: ElevatedButton.styleFrom(
                              fixedSize: Size(225, 50),
                              backgroundColor: Colors.green[400],
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30))),
                        ),
                      ),
                    ),
                  )
                ]),
              ),
              body: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/grass.jpg'), fit: BoxFit.cover)),
                child: const DungenList(),
              ));
        }
      ),
    );
  }
}
