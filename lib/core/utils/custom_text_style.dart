import 'package:color_picker_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

abstract class CustomTextStyle {
  static const whiteText = TextStyle(color: AppColors.white);
  static const white60Text = TextStyle(color: AppColors.white60);
  static const white70Text = TextStyle(color: AppColors.white70);
  static const whiteTextw600Size20 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );
  static const whiteTextBolSize20 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
  static const white70TextSize12Monospace = TextStyle(
    fontSize: 12,
    color: AppColors.white70,
    fontFamily: 'monospace',
  );
}
