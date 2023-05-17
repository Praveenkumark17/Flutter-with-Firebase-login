import 'package:flutter/material.dart';
import 'package:dungen/screen/authenticate/sign_in.dart';
import 'package:dungen/service/auth.dart';
import 'package:dungen/shared/constants.dart';
import 'package:dungen/shared/loading.dart';

class Register extends StatefulWidget {
  // Register({Key? key}) : super(key: key);

  final Function toggleView;
  Register({required this.toggleView});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  bool loading = false;

  //text field
  String email = "";
  String password = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.green[50],
            appBar: AppBar(
              backgroundColor: Colors.green[400],
              elevation: 0.0,
              title: const Text('Sign Up Page'),
              actions: [
                TextButton.icon(
                  style: TextButton.styleFrom(
                    primary: Colors.black,
                  ),
                  onPressed: () {
                    widget.toggleView();
                  },
                  icon: Icon(Icons.login),
                  label: Text('sign In'),
                )
              ],
            ),
            body: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      decoration: textinputDecoration.copyWith(
                        hintText: 'Email',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter an email';
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      decoration: textinputDecoration.copyWith(
                        hintText: 'Password',
                      ),
                      validator: (value) {
                        if (value!.length < 6) {
                          return 'Enter an password of 6+ chars';
                        } else {
                          return null;
                        }
                      },
                      obscureText: true,
                      onChanged: (value) {
                        setState(() {
                          password = value;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    ),
                    Expanded(
                      child: Align(
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formkey.currentState!.validate()) {
                              setState(() {
                                loading = true;
                              });
                              setState(() {
                                TextFormField(
                                  decoration: textinputDecoration,
                                );
                              });
                              dynamic result = await _auth
                                  .registerwithemailandpass(email, password);
                              // dynamic result = null;
                              if (result == null) {
                                setState(() {
                                  error = "Invalid email address";
                                  loading = false;
                                });
                              }
                              print(email);
                              print(password);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(280, 55),
                            backgroundColor: Colors.green[400],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 12.0),
                  ],
                ),
              ),
            ),
          );
  }
}
