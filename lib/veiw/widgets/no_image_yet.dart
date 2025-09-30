import 'package:color_picker_app/core/utils/custom_text_style.dart';
import 'package:flutter/material.dart';

Center noImageYet(String Function(String key) t) {
  return Center(child: Text(t('no_image'), style: CustomTextStyle.white60Text));
}
