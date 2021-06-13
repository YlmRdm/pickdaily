import 'package:flutter/material.dart';

ElevatedButton returnButton(BuildContext context) {
  return ElevatedButton(
    onPressed: () {
      Navigator.of(context).pop();
    },
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(
        Colors.transparent,
      ),
      padding: MaterialStateProperty.all(
        EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 8,
        ),
      ),
    ),
    child: Icon(
      Icons.arrow_back_ios_outlined,
      size: 38,
    ),
  );
}
