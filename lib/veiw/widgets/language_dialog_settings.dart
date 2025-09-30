import 'dart:ui' show ImageFilter;

import 'package:color_picker_app/core/model/localization.dart';
import 'package:color_picker_app/core/utils/app_colors.dart';
import 'package:color_picker_app/core/utils/custom_text_style.dart';
import 'package:color_picker_app/providers/color_providers.dart';
import 'package:color_picker_app/veiw/widgets/borders_style.dart';
import 'package:color_picker_app/veiw/widgets/custom_radio_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void languagedialogsettings(
  BuildContext context,
  ColorPickerNotifier notifier,
  WidgetRef ref,
) {
  showDialog(
    context: context,
    barrierDismissible: true,
    barrierColor: AppColors.black.withValues(alpha: 0.5),
    builder: (context) {
      final currentLangFromStates = ref.read(colorPickerProvider).locale;
      return Center(
        child: Material(
          color: AppColors.transparent,
          child: ClipRRect(
            borderRadius: borderRaduis(30),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Container(
                width: 340,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.white.withValues(alpha: 0.05),
                  borderRadius: borderRaduis(30),
                  border: Border.all(
                    color: AppColors.white.withValues(alpha: 0.2),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.black.withValues(alpha: 0.4),
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
                        borderRadius: borderRaduis(30),
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: AppColors.white.withValues(alpha: 0.2),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.close,
                            size: 18,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.language, color: AppColors.white),
                        const SizedBox(width: 8),
                        Text(
                          AppLocalizations().t(
                            'language',
                            currentLangFromStates,
                          ),
                          style: CustomTextStyle.whiteTextw600Size20,
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Theme(
                      data: Theme.of(context).copyWith(
                        unselectedWidgetColor: AppColors.white.withValues(
                          alpha: 0.7,
                        ),
                      ),
                      child: Column(
                        children: [
                          customRadioListTile(
                            text: 'العربية',
                            currentLanguage: 'ar',
                            current: currentLangFromStates,
                            notifier: notifier,
                            context: context,
                          ),
                          customRadioListTile(
                            text: 'English',
                            currentLanguage: 'en',
                            current: currentLangFromStates,
                            notifier: notifier,
                            context: context,
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
