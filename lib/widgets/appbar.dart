import 'package:flutter/material.dart';

AppBar buildAppBar(Widget child) {
  return AppBar(
    automaticallyImplyLeading: false,
    elevation: 0,
    backgroundColor: Color(0xFF010101),
    actions: <Widget>[child],
  );
}
