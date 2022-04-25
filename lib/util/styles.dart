import 'package:flutter/material.dart';

import 'colors.dart';

final ButtonStyle style =
  ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      minimumSize: const Size(100, 40),
      maximumSize: const Size(300, 40),
      primary: secondaryColor,
      elevation: 0,
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
      textStyle: const TextStyle(fontSize: 15)
  );