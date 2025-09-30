import 'dart:ui';
import 'package:flutter/material.dart';

void openLanguageSettings({
  required BuildContext context,
  required Locale currentLocale,
  required Function(Locale) onLocaleChanged,
  required String Function(String key) t,
}) {
  showDialog(
    context: context,
    barrierDismissible: true,
    barrierColor: Colors.black.withValues(alpha: 0.5),
    builder: (context) {
      return Center(
        child: Material(
          color: Colors.transparent,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Container(
                width: 340,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.2),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.4),
                      blurRadius: 30,
                      offset: const Offset(0, 20),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: () => Navigator.pop(context),
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.close,
                            size: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.language, color: Colors.white),
                        const SizedBox(width: 8),
                        Text(
                          t('language'),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Theme(
                      data: Theme.of(context).copyWith(
                        unselectedWidgetColor: Colors.white.withValues(
                          alpha: 0.7,
                        ),
                      ),
                      child: Column(
                        children: [
                          RadioListTile<Locale>(
                            title: const Text(
                              'العربية',
                              style: TextStyle(color: Colors.white),
                            ),
                            value: const Locale('ar'),
                            groupValue: currentLocale,
                            activeColor: Colors.orange,
                            onChanged: (val) {
                              onLocaleChanged(val!);
                              Navigator.pop(context);
                            },
                          ),
                          RadioListTile<Locale>(
                            title: const Text(
                              'English',
                              style: TextStyle(color: Colors.white),
                            ),
                            value: const Locale('en'),
                            groupValue: currentLocale,
                            activeColor: Colors.orange,
                            onChanged: (val) {
                              onLocaleChanged(val!);
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}
