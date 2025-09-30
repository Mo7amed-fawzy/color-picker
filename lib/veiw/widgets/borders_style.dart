import 'package:flutter/material.dart';

ButtonStyle customElevatedButtonStyle({
  required Color backgroundColor,
  double horizontal = 12,
  double vertical = 10,
  double borderRadius = 8,
}) {
  return ElevatedButton.styleFrom(
    backgroundColor: backgroundColor,
    padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
    shape: RoundedRectangleBorder(borderRadius: borderRaduis(borderRadius)),
  );
}
// BorderRadius borderRaduis(double borderRadius) => borderRaduis(borderRadius);

BorderRadius borderRaduis(double borderRadius) {
  return BorderRadius.circular(borderRadius);
}
