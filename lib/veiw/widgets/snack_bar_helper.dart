import 'package:flutter/material.dart';

void snackBarHelper(String text, BuildContext context, [int? duration]) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(text), duration: Duration(seconds: duration ?? 2)),
  );
}
