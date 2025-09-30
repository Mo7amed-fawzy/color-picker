import 'package:flutter/material.dart';

class AppLocalizations {
  static const Map<String, Map<String, String>> localizedValues = {
    'ar': {
      'app_title': '🎨 أداة اختيار الألوان',
      'choose_image': 'اختر صورة',
      'no_image': 'متختار صورة وتخلص يعم',
      'current_color': 'اللون الحالي:',
      'save_color': 'حفظ اللون',
      'cancel': 'إلغاء',
      'saved_colors': 'الألوان المحفوظة:',
      'reset': 'إعادة تعيين',
      'export': 'تصدير كملف',
      'share': 'مشاركة الألوان',
      'settings': 'الإعدادات',
      'language': 'اللغة',
      'arabic': 'العربية',
      'english': 'الإنجليزية',
    },
    'en': {
      'app_title': '🎨 Color Picker Tool',
      'choose_image': 'Pick Image',
      'no_image': 'No image selected',
      'current_color': 'Current Color:',
      'save_color': 'Save Color',
      'cancel': 'Cancel',
      'saved_colors': 'Saved Colors:',
      'reset': 'Reset',
      'export': 'Export File',
      'share': 'Share Colors',
      'settings': 'Settings',
      'language': 'Language',
      'arabic': 'Arabic',
      'english': 'English',
    },
  };

  /// Get translation for [key] using [locale].
  /// If key not found in chosen language, falls back to English.
  /// If still missing, returns the key itself.
  String t(String key, Locale locale) {
    final code = locale.languageCode;
    return localizedValues[code]?[key] ?? localizedValues['en']?[key] ?? key;
  }
}
