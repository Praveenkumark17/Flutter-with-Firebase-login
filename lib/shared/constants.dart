import 'package:flutter/material.dart';

final textinputDecoration = InputDecoration(
  fillColor: Colors.green[200],
  filled: true,
  enabledBorder:  OutlineInputBorder(
    borderRadius: BorderRadius.circular(30),
    borderSide: BorderSide(
      color: Color.fromRGBO(68, 179, 66, 1),
      width: 2.0,
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(30),
    borderSide: BorderSide(
      color: Color.fromRGBO(12, 87, 10, 1),
      width: 2.0,
    ),
  ),
  errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: 2.0,),
      borderRadius: BorderRadius.circular(30),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: 2.0,),
      borderRadius: BorderRadius.circular(30),
    ),
);
