import 'package:color_picker_app/core/model/localization.dart';
import 'package:color_picker_app/core/utils/app_colors.dart';
import 'package:color_picker_app/core/utils/custom_text_style.dart';
import 'package:color_picker_app/providers/color_providers.dart';
import 'package:color_picker_app/veiw/widgets/actions_bar.dart';
import 'package:color_picker_app/veiw/widgets/borders_style.dart';
import 'package:color_picker_app/veiw/widgets/language_dialog_settings.dart';
import 'package:color_picker_app/veiw/widgets/no_image_yet.dart';
import 'package:color_picker_app/veiw/widgets/snack_bar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ColorPickerScreen extends ConsumerStatefulWidget {
  const ColorPickerScreen({super.key});

  @override
  ConsumerState<ColorPickerScreen> createState() => _ColorPickerScreenState();
}

class _ColorPickerScreenState extends ConsumerState<ColorPickerScreen> {
  final GlobalKey _imageKey = GlobalKey();

  /// Get box RenderBox and size. Returns null if not available.
  RenderBox? _imageRenderBox() =>
      _imageKey.currentContext?.findRenderObject() as RenderBox?;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(colorPickerProvider);
    final notifier = ref.read(colorPickerProvider.notifier);
    String t(String key) => AppLocalizations().t(key, state.locale);

    final hasImage = state.imageBytes != null;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => languagedialogsettings(context, notifier, ref),
          ),
        ],
        title: Text(t('app_title'), style: CustomTextStyle.whiteTextBolSize20),
        centerTitle: true,
        backgroundColor: AppColors.black,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Pick image button
              ElevatedButton.icon(
                onPressed: () async {
                  final res = await notifier.pickImage();
                  if (res == 'image_selected') {
                    snackBarHelper(t('choose_image') + ' ✓', context);
                  }
                },
                icon: const Icon(Icons.image, color: AppColors.white),
                label: Text(
                  t('choose_image'),
                  style: CustomTextStyle.whiteText,
                ),
                style: customElevatedButtonStyle(
                  backgroundColor: const Color(0xFF2C2C2E),
                  horizontal: 24,
                  vertical: 16,
                  borderRadius: 12,
                ),
              ),

              const SizedBox(height: 20),

              // Image area
              Expanded(
                child:
                    hasImage
                        ? GestureDetector(
                          onTapDown: (details) {
                            final box = _imageRenderBox();
                            if (box == null) return;
                            final local = box.globalToLocal(
                              details.globalPosition,
                            );
                            final boxSize = box.size;
                            final color = notifier.pickColorAtPosition(
                              local,
                              boxSize,
                            );
                            if (color != null) {
                              // Force rebuild
                            }
                          },

                          onPanUpdate: (details) {
                            final box = _imageRenderBox();
                            if (box == null) return;
                            final local = box.globalToLocal(
                              details.globalPosition,
                            );
                            final boxSize = box.size;
                            if (!state.hasSelectedColor) {
                              notifier.previewColorFromPosition(local, boxSize);
                            }
                          },

                          child: MouseRegion(
                            cursor: SystemMouseCursors.precise,
                            onHover: (event) {
                              final box = _imageRenderBox();
                              if (box == null) return;
                              if (!state.hasSelectedColor) {
                                final local = box.globalToLocal(event.position);
                                notifier.previewColorFromPosition(
                                  local,
                                  box.size,
                                );
                              }
                            },

                            child: Stack(
                              children: [
                                Container(
                                  key: _imageKey,
                                  constraints: const BoxConstraints(
                                    minHeight: 200,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: borderRaduis(12),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: AppColors.black54,
                                        blurRadius: 10,
                                        offset: Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  clipBehavior: Clip.hardEdge,
                                  child: Image.memory(
                                    state.imageBytes!,
                                    fit: BoxFit.contain,
                                  ),
                                ),

                                // pointer preview bubble
                                if (state.pointerPosition != null &&
                                    state.previewColor != null)
                                  Positioned(
                                    left: state.pointerPosition!.dx - 12,
                                    top: state.pointerPosition!.dy - 12,
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 24,
                                          height: 24,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: AppColors.white,
                                              width: 2,
                                            ),
                                            color: state.previewColor,
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppColors.black87,
                                            borderRadius: borderRaduis(6),
                                          ),
                                          child: Text(
                                            state.previewColor != null
                                                ? '#${state.previewColor!.value.toRadixString(16).padLeft(8, '0').toUpperCase()}'
                                                : '',
                                            style:
                                                CustomTextStyle
                                                    .white70TextSize12Monospace,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        )
                        : noImageYet(t),
              ),

              const SizedBox(height: 20),

              // Current/preview color + actions
              // Preview فقط (لو مفيش selectedColor)
              if (state.selectedColor == null && state.previewColor != null)
                Column(
                  children: [
                    Text(
                      t('preview_color'),
                      style: CustomTextStyle.white70Text,
                    ),
                    const SizedBox(height: 8),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: state.previewColor,
                        border: Border.all(color: AppColors.amber, width: 2),
                        borderRadius: borderRaduis(40),
                      ),
                    ),
                  ],
                ),

              // اللون المتحدد (بعد الـ tap)
              if (state.selectedColor != null && state.hasSelectedColor)
                Column(
                  children: [
                    Text(
                      t('current_color'),
                      style: CustomTextStyle.white70Text,
                    ),
                    const SizedBox(height: 8),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      width: state.showSaveAnimation ? 70 : 60,
                      height: state.showSaveAnimation ? 70 : 60,
                      decoration: BoxDecoration(
                        color: state.selectedColor,
                        border: Border.all(
                          color:
                              state.showSaveAnimation
                                  ? AppColors.greenAccent
                                  : AppColors.white,
                          width: state.showSaveAnimation ? 4 : 2,
                        ),
                        borderRadius: borderRaduis(40),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () async {
                            final hex = await notifier.saveColor(
                              state.selectedColor!,
                            );
                            if (hex != null) {
                              snackBarHelper('تم حفظ اللون: $hex', context);
                            } else {
                              snackBarHelper('اللون موجود بالفعل', context);
                            }
                          },
                          icon: const Icon(Icons.save, color: AppColors.white),
                          label: Text(
                            t('save_color'),
                            style: CustomTextStyle.whiteText,
                          ),
                          style: customElevatedButtonStyle(
                            backgroundColor: AppColors.deepPurple,
                          ),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton.icon(
                          onPressed: () => notifier.cancelSelection(),
                          icon: const Icon(Icons.close, color: AppColors.white),
                          label: Text(
                            t('cancel'),
                            style: CustomTextStyle.whiteText,
                          ),
                          style: customElevatedButtonStyle(
                            backgroundColor: AppColors.redAccent,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

              const SizedBox(height: 20),

              // Saved AppColors list + actions
              if (state.savedColors.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(t('saved_colors'), style: CustomTextStyle.white70Text),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children:
                          state.savedColors.map((sc) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    // copy hex code
                                    final code = sc.toHex();
                                    Clipboard.setData(
                                      ClipboardData(text: code),
                                    );
                                    snackBarHelper(
                                      'تم نسخ الكود: $code',
                                      context,
                                    );
                                  },
                                  child: Container(
                                    width: 36,
                                    height: 36,
                                    decoration: BoxDecoration(
                                      color: sc.color,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: AppColors.white,
                                        width: 1.5,
                                      ),
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    size: 18,
                                    color: AppColors.white54,
                                  ),
                                  onPressed: () {
                                    notifier.removeSavedColor(sc);
                                  },
                                ),
                              ],
                            );
                          }).toList(),
                    ),
                    const SizedBox(height: 12),
                    ActionsBar(notifier: notifier, t: t),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
