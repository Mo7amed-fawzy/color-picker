import 'package:color_picker_app/core/utils/app_colors.dart';
import 'package:color_picker_app/core/utils/custom_text_style.dart';
import 'package:color_picker_app/providers/color_providers.dart';
import 'package:flutter/material.dart';

RadioListTile<Locale> customRadioListTile({
  required String text,
  required String currentLanguage,
  required Locale current,
  required ColorPickerNotifier notifier,
  required BuildContext context,
}) {
  return RadioListTile<Locale>(
    title: Text(text, style: CustomTextStyle.whiteText),
    value: Locale(currentLanguage),
    groupValue: current,
    activeColor: AppColors.orange,
    onChanged: (val) {
      if (val == null) return;
      notifier.setLocale(val);
      Navigator.pop(context);
    },
  );
}
